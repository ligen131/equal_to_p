extends Node


const Block := preload("res://objects/block/block.tscn")
const CardBase := preload("res://objects/card_base/card_base.tscn")
const LevelMenu := preload("res://levels/chapter_menu/level_menu/level_menu.tscn")
const TableCloth := preload("res://objects/table_cloth/table_cloth.tscn")
const HEIGHT := 1080 / 4
const WIDTH := 1920 / 4
const SEP := 28
const CARDS_SEP := 34


var expr := ""
var req_pos = [] # Array[int]
var chap_id : int
var lvl_id : int


const DATA := [
	[
		["=P", "P {} {}", "= P"],
		["P", "P [] {}", "= P P"],
		["=D", "D {} {}", "= D P"],
		["Reverse", "{} {} []", "d d = P P D D"]
	],
	[
		["False", "[] [] 0 {} {}", "= + P P"],
		["True", "[] {} {} [] 1", "= + P 1"],
		["Swap", "Q + [] = {} + []", "P P P P Q Q Q Q"],
		["Always True", "[] [] {} = {} [] []", "11++PPdd"],
		["Not Really Challenging", "1 [] [] [] {} [] [] [] {} [] {} [] []", "== ++++++ 11 P q b R"]
	],
	[
		["Laughing", "1 {} {} = []", "XDD"],
		["Reset", "0 [] [] {} []", "XD=0"],
		["Not Necessary", "[] {} {} {} {} []", "QQQQQQ DDXX="],
		["Golden Experience", "{} {} {} {} {} {} {} {} {} {} {}", "PP DD qq dd bb XXX ="],
	],
	[
		["He Goes First", "[] [] + [] = ( [] {} {} ) [] []", "PP QQ RR X +"],
		["Still, He Goes First", "[] + [] [] = [] [] ( [] {} {} )", "PP QQ RR X +"],
		["It's My Turn", "P ([] [] []) = {} [] [] [] []", "PP QQ RR ++"],
		["[EX] Really Challenging", "[] [] [] [] [] {} {} [] [] [] [] {} {} + [] []", "PPP QQ DD (()) ++ = X"]
	],
	[
		["Why?", "[] [] {} = {} [] {} = []", "PP qq ++ 1"],
		["Where is the Equation?", "[] [] {} {} [] + [] [] {} {} []", "(())==01PP"],
	]
]



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
	
	var lvl_name = DATA[chap_id][lvl_id][0]
	var question = DATA[chap_id][lvl_id][1].replace(" ", "").replace("X", "*")
	var choices = count(DATA[chap_id][lvl_id][2].replace(" ", "").replace("X", "*"))
	
	
	$HUDs/Title.set_text("%d-%d  %s" % [chap_id + 1, lvl_id + 1, lvl_name])
	
	
	
	question = question.replace("[]", ".")
	question = question.replace("{}", "_")
		
	
	var table_cloth = TableCloth.instantiate()
	var sep := SEP
	
	if len(question) >= 16:
		sep = SEP
	else:
		sep = int((1 - len(question) / 16.0) * SEP * 0.3) + SEP
	
	table_cloth.size.x = sep * len(question) + 16
	table_cloth.size.y = 48
	table_cloth.get_child(0).size.x = sep * len(question) + 16
	table_cloth.get_child(0).size.y = 48
	table_cloth.position.x = WIDTH / 2 - sep * len(question) / 2 - 12
	table_cloth.position.y = HEIGHT / 2 - 24
	$HUDs.add_child(table_cloth)
		
	var pos := WIDTH / 2 - sep * len(question) / 2 + 12
	for i in range(len(question)):
		var ch = question[i]
		
		var new_block := Block.instantiate()

		new_block.quest_pos = i
		if ch != "." and ch != "_":
			new_block.occupied = true
			new_block.set_word(ch)
			new_block.set_block_type("CONST")
		else:
			new_block.set_word("_")
			if ch == "_":
				req_pos.append(i)
				new_block.set_block_type("GOLDEN")
			else:
				new_block.set_block_type("PIT")
		new_block.set_position(Vector2(pos, HEIGHT / 2))
		pos += sep
		
		$Blocks.add_child(new_block)
	
	expr = question
	print(expr)
	
	
	pos = WIDTH / 2 - CARDS_SEP * len(choices) / 2 + 20
	for ch in choices:
		var new_card_base := CardBase.instantiate()

		new_card_base.set_word(ch)
		
		new_card_base.set_card_count(choices[ch])
		new_card_base.set_position(Vector2(pos, HEIGHT * 6 / 7))
		pos += CARDS_SEP
		
		$CardBases.add_child(new_card_base)
		new_card_base.card_put.connect(_on_card_put)


func _ready():
	$HUDs/BackButton/icon.play("return")
	$HUDs/ReplayButton/icon.play("replay")

func _process(_delta):
	pass


func stage_clear() -> void:
	$SFXs/LevelClear.play()
	for card_base: CardBase in $CardBases.get_children():
		card_base.call("start_fade")
	$HUDs/TableCloth/GoldenCloth.set_visible(true)


func _on_card_put() -> void:
	for block : Block in $Blocks.get_children():
		if not block.occupied:
			print(block.quest_pos, " is not occupied")
			return
		expr[block.quest_pos] = block.occupied_word
		
	prints("# expr: ", expr)
	
	if expr.count("_") == 0:
		var info = $Calculator.check(expr, req_pos)
		prints("expr:", expr)
		prints("info:", info)
		
		if info[0] != "OK":
			$SFXs/WrongAnswer.play()
		
		if info[0] == "INVALID":
			for block: Block in $Blocks.get_children():
				if block.quest_pos in info[1]:
					block.call("shake")
		elif info[0] == "SMILE_UNSATISFIED":
			for block: Block in $Blocks.get_children():
				if block.quest_pos == info[1]:
					block.call("shake")
		elif info[0] == "NOT_ALWAYS_TRUE":
			for block: Block in $Blocks.get_children():
				block.call("shake")
		else:
			stage_clear()
			


func _on_back_button_pressed():
	var level_menu = LevelMenu.instantiate()
	level_menu.init(chap_id, -1)
	get_tree().root.add_child(level_menu)
	queue_free()


func _on_replay_button_pressed():
	print("TO-DO here to handle replay")
	pass
