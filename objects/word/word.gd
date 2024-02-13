extends AnimatedSprite2D


@export var text_id := 0
@export var color := Color.BLACK


const STEP := 30
const LETTER_NAME = [" ", "=", "P", "b", "D", 
"I1", "I2", "I3", "I4", "I5", 
"R", "Q", "d", "q", "(",
"*", "+", "<", ">", ")",
"0", "1", "2", "3", "4",
"5", "6", "7", "8", "9"]


## 内建，不要用。
func get_letter_id(letter: String) -> int:
	for i in range(len(LETTER_NAME)):
		if LETTER_NAME[i] == letter:
			return i
	assert(false, "Letter " + letter + " not found")
	return -1
	

## 内建，不要用。
func set_text_id(value: int) -> void:
	assert(value >= 0, "text id < 0")
	text_id = value
	update_animation()

func update_animation() -> void:
	ImageLib.update_animation(self, text_id + 1, 3, STEP, "res://objects/word/sprites/sprite%d.png", Color.BLACK, color)
	
	

## 更改字母为 text。
func set_word(text: String) -> void:
	if text == "_" or text == ".":
		set_text_id(0)
	else:
		set_text_id(get_letter_id(text))

## 获得当前字母。
func get_word() -> String:
	return LETTER_NAME[text_id]


func _ready():
	update_animation()

func set_color(value: Color) -> void:
	color = value
	update_animation()

## 设置是否为关卡通过状态。
## 已弃用，请使用 set_color 或 set_color_from_name 代替。
## @deprecated
func set_victory(v: bool) -> void:
	push_warning("void set_victory(v: bool) is deprecated.")
	if v:
		set_color(ImageLib.PALETTE["golden"])
	else:
		set_color(ImageLib.PALETTE["default"])
