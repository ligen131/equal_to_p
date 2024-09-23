## 表达式中的一个可被放入 [Card] 的卡槽，或是字符固定的一个格子。

class_name Block extends Area2D


## 当被占用的 [Card] 发生改变后发出。
## [br][br]
## [param block] 为发出该信号的 [Block] 对象。
signal occupied_card_changed(block: Block)



const SHAKE_AMOUNT := 3.0 ## 振动时的振幅（单位为像素）。
const SHAKE_DURATION := 0.2 ## 振动时的持续时间（单位为秒）。


var is_fixed : bool ## 是否为固定的（即在表达式中已初始化了的）。
var is_golden_frame : bool ## 是否为金色框。
var is_shaking := false ## 是否正在振动。

var is_invalid := false ## 是否为非法位置。
var is_golden := false ## 是否为金色字符。

var occupied_card: Card = null ## 占用的 Card 对象。

var ind_in_question := -1 ## 在表达式中对应字符位置的下标。



## 是否为空槽，即能否被 [Card] 占用。
func is_empty() -> bool:
	return not self.is_fixed and self.occupied_card == null


## 设置固定的字符为 [param value]。
## [br][br]
## 应当只在 [member is_fixed] 为 [code]true[/code] 时被调用。
func set_word(value: String) -> void:	
	assert(self.is_fixed, "void Block::set_word(value: String) should only be called when is_fixed is true.")
	$Word.set_word(value)


## 设置占用的 [Card] 为 [param card]。
## [br][br]
## 应当只在 [member is_fixed] 为 [code]false[/code] 时被调用。
func set_card(card: Card) -> void:
	assert(not self.is_fixed, "void Block::set_card(card: Card) should only be called when is_fixed is false.")
	if self.occupied_card != card:
		self.occupied_card = card
		if card != null:
			card.position = self.position
			card.current_block = self
		occupied_card_changed.emit(self)
	

## 获取当前字符。
## [br][br]
## 当 [member is_fixed] 为 [code]true[/code] 时，从子节点 [Word] 返回固定的字符。
## [br][br]
## 当 [member is_fixed] 为 [code]false[/code] 时，返回占用的 [Card] 的字符。
func get_word() -> String:
	if self.is_fixed:
		return $Word.get_word()
	else:
		if self.occupied_card == null:
			return " "
		else:
			return self.occupied_card.get_word()

func get_is_invalid() -> bool:
	return self.is_invalid

func set_is_invalid(value: bool) -> void:
	if get_is_invalid() == value:
		return
	
	self.is_invalid = value
	if self.occupied_card != null:
		self.occupied_card.set_is_invalid(value)

	if self.is_invalid:
		$Word.set_color(ImageLib.get_palette_color_by_name("red"))

		$Word/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)
		$GoalFrameSprite/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)
		$PitSprite/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)

	else:
		$Word.set_color(ImageLib.get_palette_color_by_name("black"))

func set_is_golden(value: bool) -> void:
	if self.is_golden == value:
		return
	
	self.is_golden = value
	if self.occupied_card != null:
		self.occupied_card.set_is_golden(value)
	
	if not self.is_invalid:
		$Word.set_color(ImageLib.get_palette_color_by_name("golden" if self.is_golden else "black"))

## 设置 [member is_fixed] 为 [param value]。
func set_is_fixed(value: bool) -> void:
	self.is_fixed = value
	$PitSprite.visible = not self.is_fixed
	$GoalFrameSprite.visible = not self.is_fixed and self.is_golden_frame


## 设置 [member is_golden_frame] 为 [param value]。
func set_is_golden_frame(value: bool) -> void:
	self.is_golden_frame = value
	$GoalFrameSprite.visible = not self.is_fixed and self.is_golden_frame
	

## 若 [param v] 为 [code]true[/code]，且有占用的 [Card]，则将其设置为通关状态（即调用 [method Card.set_victory])。
func set_victory(v: bool) -> void:
	if v and not self.is_fixed and self.occupied_card != null:
		self.occupied_card.set_victory(v)


## 设置字符颜色为 [param value]。
func set_color(value: Color) -> void:
	if self.is_fixed:
		$Word.set_color(value)	
	else:
		if self.occupied_card != null:
			self.occupied_card.set_color(value)
