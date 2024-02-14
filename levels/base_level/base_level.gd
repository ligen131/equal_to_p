extends Node


class_name BaseLevel

# FIXME
# 由于 Godot preload 容易出错，此处改为 load
var BlockScn = load("res://objects/block/block.tscn")
var CardBaseScn = load("res://objects/card_base/card_base.tscn")
var LevelMenuScn = load("res://levels/chapter_menu/level_menu/level_menu.tscn")
var TableClothScn = load("res://objects/table_cloth/table_cloth.tscn")
var BaseLevelScn = load("res://levels/base_level/base_level.tscn")


const HEIGHT := 1080 / 4
const WIDTH := 1920 / 4
const SEP := 28
const CARDS_SEP := 34


const I_NUMBER = ["I","II","III","VI","V"]


var expr := ""
var req_pos := [] # Array[int]，金色框的位置列表
var chap_id : int ## 当前章节编号
var lvl_id : int ## 当前关卡编号



func count(choices: String) -> Dictionary:
	var res := {}
	for x in choices:
		if not res.has(x):
			res[x] = 0
		res[x] += 1
	return res


func init(_chap_id: int, _lvl_id: int) -> void:
	chap_id = _chap_id
	lvl_id = _lvl_id
	
	var lvl_name = LevelData.LEVEL_DATA[chap_id][lvl_id]["name-en"]
	var question = LevelData.LEVEL_DATA[chap_id][lvl_id]["question"].replace(" ", "").replace("X", "*")
	var choices = count(LevelData.LEVEL_DATA[chap_id][lvl_id]["choices"].replace(" ", "").replace("X", "*"))
	
	
	$HUDs/Title.set_text("%s-%d  %s" % [I_NUMBER[chap_id], lvl_id + 1, lvl_name])
	
	
	
	question = question.replace("[]", ".")
	question = question.replace("{}", "_")
		
	
	var table_cloth = TableClothScn.instantiate()
	var sep := SEP
	
	if len(question) >= 16:
		sep = SEP
	else:
		sep = int((1 - len(question) / 16.0) * SEP * 0.3) + SEP
	
	table_cloth.size.x = sep * len(question) + 16 + 4
	table_cloth.size.y = 48
	table_cloth.get_child(0).size.x = sep * len(question) + 16 + 4
	table_cloth.get_child(0).size.y = 48
	table_cloth.position.x = WIDTH / 2 - sep * len(question) / 2 - 7
	table_cloth.position.y = HEIGHT / 2 - 24
	$HUDs.add_child(table_cloth)
		
	var pos := WIDTH / 2 - sep * len(question) / 2 + 12 + 7
	for i in range(len(question)):
		var ch: String = question[i]
		
		var new_block: Block = BlockScn.instantiate()

		new_block.quest_pos = i
		if ch != "." and ch != "_":
			new_block.is_fixed = true
			new_block.set_word(ch)
			new_block.set_block_type("CONST")
		else:
			new_block.is_fixed = false
			if ch == "_":
				req_pos.append(i)
				new_block.set_block_type("GOLDEN")
			else:
				new_block.set_block_type("PIT")
		new_block.set_position(Vector2(pos, HEIGHT / 2))
		pos += sep
		
		$Blocks.add_child(new_block)

		new_block.occupied_card_changed.connect(_on_block_occupied_card_changed)
	
	expr = question
	# print(expr)
	
	
	pos = WIDTH / 2 - CARDS_SEP * len(choices) / 2 + 16
	for ch in choices:
		var new_card_base: CardBase = CardBaseScn.instantiate()

		new_card_base.set_word(ch)
		
		new_card_base.set_card_count(choices[ch])
		new_card_base.set_position(Vector2(pos, HEIGHT * 6 / 7))
		pos += CARDS_SEP
		
		$CardBases.add_child(new_card_base)


func _ready():
	$HUDs/BackButton/icon.play("return")
	$HUDs/ReplayButton/icon.play("replay")

func _process(_delta):
	pass


func stage_clear() -> void:
	$SFXs/LevelClear.play()
	for card_base: CardBase in $CardBases.get_children():
		card_base.set_victory()
		
	$HUDs/TableCloth/GoldenCloth.set_visible(true)
	$HUDs/NextLevelButton.start_fade()


func _on_block_occupied_card_changed(_node) -> void:
	var block_array = []
	for block : Block in $Blocks.get_children():
		if block.is_empty():
			#print(block.quest_pos, " is not occupied")
			return
		expr[block.quest_pos] = block.get_word()
		block_array.append(block)
		
	# prints("# expr: ", expr)
	
	if expr.count("_") == 0:
		var info = ExprValidator.check(expr, req_pos)
		# prints("expr:", expr)
		# prints("info:", info)
		
		if info[0] != "OK":
			$SFXs/WrongAnswer.play()
		
		if info[0] == "INVALID":
			for block: Block in $Blocks.get_children():
				if block.quest_pos in info[1]:
					block.shake(false)
		elif info[0] == "SMILE_UNSATISFIED":
			for block: Block in $Blocks.get_children():
				if block.quest_pos in info[1]:
					block.shake(true)
		elif info[0] == "NOT_ALWAYS_TRUE":
			for block: Block in $Blocks.get_children():
				block.shake(false)
		else:
			# victory
			get_tree().current_scene.set_victory(true)
			stage_clear()
			# print(block_array)
			for i in range(len(block_array)):
				if i != 0:
					if ExprValidator.is_smile(expr[i-1]+expr[i]):
						# print(expr[i-1]+expr[i])
						block_array[i-1].set_color(ImageLib.PALETTE["golden"])
						block_array[i].set_color(ImageLib.PALETTE["golden"])

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_R and event.pressed:
			_on_replay_button_pressed()
		if event.keycode == KEY_ESCAPE and event.pressed:
			_on_back_button_pressed()


func _exit_tree():
	get_tree().current_scene.set_victory(false)


func _on_back_button_pressed():
	var level_menu = LevelMenuScn.instantiate()
	level_menu.init(chap_id, -1)
	get_tree().root.add_child(level_menu)
	queue_free()

func _on_next_level_button_pressed():
	if self.lvl_id == LevelData.get_chapter_level_count(self.chap_id) - 1:
		var level_menu = LevelMenuScn.instantiate()
		level_menu.init(chap_id + 1, -1)
		get_tree().root.add_child(level_menu)
	else:
		var base_level = BaseLevelScn.instantiate()
		base_level.init(chap_id, lvl_id + 1)
		get_tree().root.add_child(base_level)
	queue_free()
	
func _on_replay_button_pressed():
	var new_level = BaseLevelScn.instantiate()
	new_level.init(chap_id, lvl_id)
	get_tree().root.add_child(new_level)
	queue_free()
	#print(get_tree().current_scene)
	#get_tree().reload_current_scene()
	#for card_base: CardBase in $CardBases.get_children():
		#card_base.reset_all_card_position()
