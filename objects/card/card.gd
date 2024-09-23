## 写有单个字符的卡牌方块。由 [CardBase] 生成，可以被填入表达式的空格（即有空位的 [Block]）中。
class_name Card extends Area2D  


@export var sfx_put_down : AudioStream  ## 放下卡牌时的音效
@export var sfx_put_down_db : float = 0.0  ## 放下卡牌时的音效音量


const SHAKE_AMOUNT := Block.SHAKE_AMOUNT
const SHAKE_DURATION := Block.SHAKE_DURATION



var current_block: Block = null ## 当前所占用的 Block 对象。

## 当 [member is_dragging] 为 [code]true[/code] 时，[member last_block] 为拾取该 [Card] 前占用的 [Block] 对象。
## [br][br]
## 当 [member is_dragging] 为 [code]false[/code] 时，[member last_block] 为 [code]null[/code]。
var last_block: Block = null

var is_dragging := false  ## 是否正在被鼠标拖拽。
var is_shaking := false  ## 是否正在震动。

var is_invalid := false  ## 是否为非法字符。
var is_golden := false  ## 是否为金色字符。

var is_victory := false  ## 是否已通关。
var shake_amount : float  ## 震动幅度（单位为像素）。



## 获取当前最近的，[Area2D] 相交且字符不固定（即 [member Block.is_fixed] 为 [code]false[/code]）的 [Block]。
## [br][br]
## 距离按两个中心点间的距离计算。
func get_top_prior_entered_block() -> Block:
	var top_block: Block = null
	for area: Area2D in get_overlapping_areas():
		if area is Block and not area.is_fixed:
			if top_block == null or (self.position - top_block.position).length() > (self.position - area.position).length():
				top_block = area
	return top_block


## 进行被拾取时的处理。
## [br][br]
## 一般在生成 [Card] 时，以及鼠标移到 [Card] 上点击鼠标左键时调用。
func pick_up():
	self.z_index += 1
	self.is_dragging = true
	if self.current_block != null:
		self.last_block = self.current_block
		self.current_block.set_card(null)
		self.current_block = null
	else:
		self.last_block = null


## 进行被放下时的处理。
## [br][br]
## 一般在 [Card] 被拖动的过程中，点击鼠标右键时调用。
func put_down(): 
	self.z_index -= 1
	var entered_block := get_top_prior_entered_block()
	if entered_block != null:
		var old_card = entered_block.occupied_card
		entered_block.set_card(self)

		if old_card != null: # 若原来占有的卡非空，则进行交换
			if self.last_block != null: # 若当前 Card 之前占用了 Block，则将该 Block 占用的 Card 放置在原先的位置上
				self.last_block.set_card(old_card)
			else: # 若当前 Card 是由 CardBase 生成的，则将该 Block 占用的 Card 释放
				old_card.queue_free()

		self.is_dragging = false  

		self.last_block = null

		SoundManager.play_sfx(sfx_put_down, sfx_put_down_db)

		
	else:
		queue_free()	


## 使 [Card] 开始震动。
func shake() -> void:
	$HighlightSprite/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)
	$CardBackSprite/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)
	$Word/ShakeComponent.shake(SHAKE_AMOUNT, SHAKE_DURATION)
	$Word.set_color(ImageLib.get_palette_color_by_name("red"))
		

## 设置字符颜色为 [param value]。
func set_color(value: Color) -> void: 
	$Word.set_color(value)  # 设置文字颜色

## 设置非法标志为 [param value]。
func set_is_invalid(value: bool) -> void:
	self.is_invalid = value
	if self.is_invalid:
		self.shake()
	self.set_color(self.get_color())

## 设置金色标志为 [param value]。
func set_is_golden(value: bool) -> void:
	self.is_golden = value
	self.set_color(self.get_color())


## 若 [param v] 为 [code]true[/code]，则进行通关时的处理。
func set_victory(v: bool): 
	if v:
		$CollisionShape2D.set_deferred("disabled", true)  # 如果胜利，禁用碰撞形状


## 设置字符为 [param value]，同时更新卡背颜色。
func set_word(value: String) -> void:
	$Word.set_word(value) 
	var new_color_name: String
	if ExprValidator.get_char_type_as_str(get_word()) in ["VAR", "CONST"]:
		new_color_name = "light"
	else:
		new_color_name = "lightest"
	
	ImageLib.update_animation(
		$CardBackSprite, 1, 3, 1, "res://objects/card/card%d.png",
		ImageLib.get_palette_color_by_info("blue", "light"),
		ImageLib.get_palette_color_by_info("blue", new_color_name)
	)


## 获取字符。
func get_word() -> String:
	return $Word.get_word()

func get_color() -> Color:
	if self.is_invalid:
		return ImageLib.get_palette_color_by_name("red")
	elif self.is_golden:
		return ImageLib.get_palette_color_by_name("golden")
	else:
		return ImageLib.get_palette_color_by_name("black")


func _ready():  
	$HighlightSprite.visible = false


func _process(_delta: float) -> void:
	if self.is_dragging:  # 如果正在拖拽
		self.global_position = get_global_mouse_position().round()  # 将卡牌位置设置为鼠标位置的全局位置，四舍五入取整


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed(): # 如果按下左键，则拾取 Card
				pick_up()
			elif self.is_dragging: # 否则则是放开左键，此时若 [Card] 正在拖拽，则放下
				put_down()
			
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():  # 按下右键时
			queue_free()



func _on_mouse_entered():
	$HighlightSprite.visible = true


func _on_mouse_exited():
	$HighlightSprite.visible = false


func _on_tree_exiting():
	if self.current_block != null and self.current_block.occupied_card == self:
		self.current_block.set_card(null)
