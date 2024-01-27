extends AnimatedSprite2D


@export var text_id := 0


const STEP := 30
const LETTER_NAME = ["_", "=", "P", "b", "D", 
"I1", "I2", "I3", "I4", "I5", 
"R", "Q", "d", "q", "(",
"*", "+", "<", ">", ")",
"0", "1", "2", "3", "4",
"5", "6", "7", "8", "9"]


## 内建，不要用。
func get_letter_id(letter: String) -> int:
	for i in range(len(LETTER_NAME)):
		if LETTER_NAME[i] == letter:
			return i + 1
	assert(false, "Letter " + letter + " not found")
	return -1
	

## 内建，不要用。
func set_text_id(value: int) -> void:
	text_id = value
	
	if not sprite_frames.has_animation(str(text_id)):
		sprite_frames.add_animation(str(text_id))
		for i in range(3):
			sprite_frames.add_frame(str(text_id), load("res://objects/word/sprites/sprite" + str(i * STEP + text_id) + ".png"))
	animation = str(text_id)
	
	

## 更改字母为 text。
func set_word(text: String) -> void:
	if text == "_" or text == ".":
		set_text_id(1)
	else:
		set_text_id(get_letter_id(text))

## 获得当前字母。
func get_word() -> String:
	return LETTER_NAME[text_id - 1]


func _ready():
	set_text_id(text_id)


func _process(delta):
	if animation == "default":
		set_text_id(text_id)
