extends Node


const Block := preload("res://objects/block/block.tscn")
const CardBase := preload("res://objects/card_base/card_base.tscn")
const HEIGHT := 1080 / 4
const WIDTH := 1920 / 4
const SEP := 30

@export var level_id := -1


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
		["Not Really Challenging", "1 [] [] [] {} [] [] [] {} [] {} [] []", "= = + + + + + + 1 1 P q b R"]
	],
	[
		["Laughing", "1 {} {} = []", "XDD"],
		["Reset", "0 [] [] {} []", "XD10"],
		["Not Necessary", "[] {} {} {} {} []", "QQQQQQDDXX="],
		["Golden Experience", "{} {} {} {} {} {} {} {} {} {} {}", "PP DD qq dd bb XXX ="],
	],
]


func count(choices: String) -> Dictionary:
	var res := {}
	for x in choices:
		if not res.has(x):
			res[x] = 0
		res[x] += 1
	return res


func init(lvl_id: int) -> void:
	var question = DATA[lvl_id][2].replace(" ", "").replace("X", "*")
	var choices = count(DATA[lvl_id][3].replace(" ", "").replace("X", "*"))
	
	question = question.replace("[]", ".")
	question = question.replace("{}", "_")
		
	var pos : int
	pos = WIDTH / 2 - SEP * len(question) / 2 + 12
	for ch in question:
		var new_block := Block.instantiate()

		new_block.set_word(ch)
		if not ch == "." and not ch == "_":
			new_block.occupied = true
		new_block.set_position(Vector2(pos, HEIGHT / 2))
		pos += SEP
		
		$Blocks.add_child(new_block)
	
	
	
	
	pos = WIDTH / 2 - SEP * len(choices) / 2 + 12
	for ch in choices:
		var new_card_base := CardBase.instantiate()

		new_card_base.set_word(ch)
		#new_card_base.set_count(choices[ch])
		new_card_base.set_position(Vector2(pos, HEIGHT * 7 / 8))
		pos += SEP
		
		$CardBases.add_child(new_card_base)


func _ready():
	pass

func _process(_delta):
	pass
