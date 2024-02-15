## 单个字符的动画，可自定义颜色。
class_name Word extends AnimatedSprite2D




## 显示的字符下标。
## [br][br]
## 当前显示的字符应为 [code]LETTER_NAME[text_id][/code]。
@export var text_id := 0 

@export var color := Color.BLACK ## 当前字符颜色。


const STEP := 30 ## 在字符动画的资源文件夹（[code]res://objects/word/sprites[/code]）中，同一个字符相邻帧之间的文件编号差。
const LETTER_NAME = [" ", "=", "P", "b", "D", 
"I1", "I2", "I3", "I4", "I5", 
"R", "Q", "d", "q", "(",
"*", "+", "<", ">", ")",
"0", "1", "2", "3", "4",
"5", "6", "7", "8", "9"] ## 可取的字符列表。


## 获取字符 [param letter] 在 [member LETTER_NAME] 中对应的下标。
## [br][br]
## 若不存在，返回 [code]-1[/code]。
func get_letter_id(letter: String) -> int:
	for i in range(len(LETTER_NAME)):
		if LETTER_NAME[i] == letter:
			return i
	push_warning("Letter %s not found in LETTER_NAME." % letter)
	return -1
	

## 设置 [member text_id] 为 [param value] 并更新动画。
func set_text_id(value: int) -> void:
	assert(value >= 0, "text id < 0")
	text_id = value
	update_animation()


## 根据当前的 [member text_id] 更新动画。
func update_animation() -> void:
	ImageLib.update_animation(self, text_id + 1, 3, STEP, "res://objects/word/sprites/sprite%d.png", Color.BLACK, color)
	
	

## 设置字符为 [param text]。
## [br][br]
## [b]注意[/b]：若 [param text] 为 [code]_[/code] 或 [code].[/code]，则会设置为 [code] [/code]。但不推荐使用该做法。
func set_word(text: String) -> void:
	if text == "_" or text == ".":
		push_warning("set_word(%s) is not recommended." % text)
		set_text_id(0)
	else:
		set_text_id(get_letter_id(text))


## 获取当前字符。
func get_word() -> String:
	return LETTER_NAME[text_id]


## 设置字符颜色为 [param value] 并更新动画。
func set_color(value: Color) -> void:
	color = value
	update_animation()


## 设置是否为关卡通过状态。
## [br][br]
## 将废弃，请使用 [method set_color] 代替。
## [br][br]
## @deprecated
func set_victory(v: bool) -> void:
	push_warning("void set_victory(v: bool) is deprecated.")
	if v:
		set_color(ImageLib.PALETTE["golden"])
	else:
		set_color(ImageLib.PALETTE["default"])



func _ready():
	update_animation()
