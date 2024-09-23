class_name BaseLevel extends Node


@export var sfx_level_clear: AudioStream
@export var sfx_level_clear_db: float = 0.0
@export var sfx_wrong_answer: AudioStream
@export var sfx_wrong_answer_db: float = 0.0


# FIXME
# 由于 Godot preload 容易出错，此处改为 load
var BlockScn = load("res://objects/block/block.tscn")
var CardBaseScn = load("res://objects/card_base/card_base.tscn")
var LevelMenuScn = load("res://levels/chapter_menu/level_menu/level_menu.tscn")
var TableClothScn = load("res://objects/table_cloth/table_cloth.tscn")
var BaseLevelScn = load("res://levels/base_level/base_level.tscn")


const HEIGHT := 1080 / 3
const WIDTH := 1920 / 3
const PADDING := 5
const MARGIN := 12
const CARDS_SEP := 34


var expr := ""
var req_pos := [] # Array[int]，金色框的位置列表
var chap_id: int ## 当前章节编号
var lvl_id: int ## 当前关卡编号


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
	
	var lvl_name = "LEVEL_NAME_%d_%d" % [chap_id, lvl_id]
	var question = LevelData.LEVEL_DATA[chap_id][lvl_id]["question"].replace(" ", "").replace("X", "*")
	var choices = count(LevelData.LEVEL_DATA[chap_id][lvl_id]["choices"].replace(" ", "").replace("X", "*"))
	
	
	$HUDs/Title.set_text("%d-%d  %s" % [chap_id + 1, lvl_id + 1, tr(lvl_name)])
	
	
	question = question.replace("[]", ".")
	question = question.replace("{}", "_")
		
	
	var table_cloth = TableClothScn.instantiate()
	var padding: int
	
	if len(question) >= 16:
		padding = 0
	else:
		padding = int((1 - len(question) / 16.0) * 6 + 0.5) / 2 * 2
	
	table_cloth.size.x = MARGIN * 2 + 28 * len(question) + padding * (len(question) - 1)
	table_cloth.size.y = 48
	table_cloth.get_child(0).size.x = MARGIN * 2 + 28 * len(question) + padding * (len(question) - 1)
	table_cloth.get_child(0).size.y = 48
	table_cloth.position.x = WIDTH / 2 - table_cloth.size.x / 2
	table_cloth.position.y = HEIGHT / 2 - table_cloth.size.y / 2
	$HUDs.add_child(table_cloth)
		
	var pos: int = table_cloth.position.x + MARGIN + 28 / 2
	for i in range(len(question)):
		var ch: String = question[i]
		
		var new_block: Block = BlockScn.instantiate()

		new_block.ind_in_question = i
		if ch != "." and ch != "_":
			new_block.set_is_fixed(true)
			new_block.set_word(ch)
		else:
			new_block.set_is_fixed(false)
			if ch == "_":
				req_pos.append(i)
				new_block.set_is_golden_frame(true)
			else:
				new_block.set_is_golden_frame(false)
		new_block.set_position(Vector2(pos, HEIGHT / 2))
		pos += 28 + padding
		
		$Blocks.add_child(new_block)

		new_block.occupied_card_changed.connect(_on_block_occupied_card_changed)
	
	expr = question
	# print(expr)
	
	pos = WIDTH / 2 - CARDS_SEP * (len(choices) - 1) / 2
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
	SoundManager.play_sfx(sfx_level_clear, sfx_level_clear_db)
	for card_base: CardBase in $CardBases.get_children():
		card_base.set_victory()
		
	$HUDs/TableCloth/GoldenCloth.set_visible(true)
	$HUDs/NextLevelButton.start_fade()


func _on_block_occupied_card_changed(_node) -> void:
	var block_array : Array[Block]
	block_array.assign($Blocks.get_children())

	var sfx_wa_flag := false

	# 获取 expr
	for block in block_array:
		if block.is_empty():
			expr[block.ind_in_question] = "_"
		else:
			expr[block.ind_in_question] = block.get_word()
		
	prints()
	prints("# expr: ", expr)

	# 检查表达式是否合法，并设置 invalid 标志
	var invalid_inds := ExprValidator.check_invalid(expr)
	for block in block_array:
		if block.ind_in_question in invalid_inds:
			if not block.get_is_invalid():
				sfx_wa_flag = true
			block.set_is_invalid(true)
		else:
			block.set_is_invalid(false)
	
	print("# invalid_inds: ", invalid_inds)
	
	# 检查表达式笑脸列表，并设置 is_golden 标志
	var smile_inds := ExprValidator.get_smile_inds(expr)
	for block in block_array:
		block.set_is_golden(block.ind_in_question in smile_inds)
		
	print("# smile_inds: ", smile_inds)

	# 若表达式合法，且已填满，则考虑检查是否满足笑脸要求
	if invalid_inds.size() == 0 and expr.find("_") == -1:
		var smile_unsatisfied_inds: Array[int]
		smile_unsatisfied_inds.assign(req_pos.filter(func(ind: int): return ind not in smile_inds))

		# 若不满足，则设置不满足笑脸要求的块为 invalid
		if smile_unsatisfied_inds.size() > 0:
			for block in block_array:
				if block.ind_in_question in smile_unsatisfied_inds:
					if not block.get_is_invalid():
						sfx_wa_flag = true
					block.set_is_invalid(true)

		# 若满足笑脸要求，则检测是否恒等
		else:
			
			print("# check: ", ExprValidator.check_always_true(expr))
			if not ExprValidator.check_always_true(expr).is_empty():
				# 若不恒等，设置所有块为 invalid
				for block in block_array:
					if not block.get_is_invalid():
						sfx_wa_flag = true
					block.set_is_invalid(true)

			else:
				get_tree().current_scene.set_victory(true)
				stage_clear()


	if sfx_wa_flag:
		SoundManager.play_sfx(sfx_wrong_answer, sfx_wrong_answer_db)

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
	get_tree().root.add_child(level_menu)
	level_menu.init(chap_id)
	queue_free()

func _on_next_level_button_pressed():
	if self.lvl_id == LevelData.get_chapter_level_count(self.chap_id) - 1:
		var level_menu = LevelMenuScn.instantiate()
		get_tree().root.add_child(level_menu)
		level_menu.init(chap_id)
	else:
		var base_level = BaseLevelScn.instantiate()
		get_tree().root.add_child(base_level)
		base_level.init(chap_id, lvl_id + 1)
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
