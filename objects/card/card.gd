extends Area2D  

class_name Card 


var is_dragging := false  ## 是否正在被拖拽。

var current_block: Block = null ## 当前所占用的 Block 对象。

var is_victory := false  ## 是否已通关。

var shake_amount : float  ## 震动幅度（单位为像素）。
var is_shaking := false  ## 是否正在震动。



## 获取当前最近的，Area 相交的，且未被占用的 Block。
##
## 距离按两个中心点间的距离计算。
func get_top_prior_entered_block() -> Block:
	var top_block: Block = null
	for area: Area2D in get_overlapping_areas():
		if area is Block and area.is_empty():
			if top_block == null or (self.position - top_block.position).length() > (self.position - area.position).length():
				top_block = area
	return top_block


## 进行被拾取时的处理。
##
## 一般在生成 Card 时，以及鼠标移到 Card 上点击鼠标左键时调用。
func pick_up():
	self.z_index += 1
	self.is_dragging = true
	if self.current_block != null:
		self.current_block.set_card(null)
		self.current_block = null


## 进行被放下时的处理。
##
## 一般在 Card 被拖动的过程中，点击鼠标右键时调用。
func put_down(): 
	self.z_index -= 1
	var entered_block := get_top_prior_entered_block()
	if entered_block != null:
		self.current_block = entered_block
		self.position = entered_block.position
		self.is_dragging = false  

		$SFXPutDown.play() 

		entered_block.set_card(self)
		
	else:
		queue_free()	


## 使 Card 开始震动。
##
## * is_letter_red：是否要将字符颜色改为红色
## * amount：震动幅度
## * duration：震动持续时长
func shake(is_letter_red: bool, amount: float, duration: float) -> void:
	$ShakeTimer.wait_time = duration
	self.shake_amount = amount
	
	# 开启震动
	$ShakeTimer.start()
	self.is_shaking = true
	
	if is_letter_red:
		$Word.set_color(ImageLib.PALETTE["red"])
	else:
		$HighlightSprite.visible = false
		

## 设置字符颜色。
func set_color(value: Color) -> void:  # 设置颜色函数
	$Word.set_color(value)  # 设置文字颜色


## 设置是否为胜利状态。
func set_victory(v: bool):  # 设置胜利状态函数
	if v:
		$CollisionShape2D.set_deferred("disabled", true)  # 如果胜利，禁用碰撞形状


## 设置字符为 value，同时更新卡背颜色。
func set_word(value: String) -> void:
	$Word.set_word(value) 
	var card_type := "card-%s" % ExprValidator.get_char_type_as_str(get_word()).to_lower()  # 根据单词类型获取卡牌类型
	if ImageLib.PALETTE.has(card_type):  # 如果配色盘中包含该卡牌类型对应颜色，则更新卡背颜色
		ImageLib.update_animation(
			$CardBackSprite, 1, 3, 1, "res://objects/card/card%d.png", 
			ImageLib.PALETTE["lightblue"], ImageLib.PALETTE[card_type] 
		)


## 获取字符。
func get_word() -> String:
	return $Word.get_word()



func _ready():  
	$HighlightSprite.visible = false


func _process(_delta: float) -> void:
	if self.is_dragging:  # 如果正在拖拽
		self.global_position = get_global_mouse_position().round()  # 将卡牌位置设置为鼠标位置的全局位置，四舍五入取整
		
	var offset := 0
	if self.is_shaking:  
		# 如果正在震动，则设置震动偏移量为 sin(progress) * self.shake_amount
		# 其中 progress in [0, 2 * PI] 是震动进度，随着时间的推移逐渐增加
		# self.shake_amount 是震动幅度
		var progress = (1 - $ShakeTimer.time_left / $ShakeTimer.wait_time) * 2 * PI
		offset = int(sin(progress) * self.shake_amount)

	# 设置 Sprite 的震动偏移量
	$CardBackSprite.position.x = offset  
	$HighlightSprite.position.x = offset  
	$Word.position.x = offset 


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed(): # 如果按下左键，则拾取 Card
				pick_up()
			elif self.is_dragging: # 否则则是放开左键，此时若 Card 正在拖拽，则放下
				put_down()
			
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():  # 按下右键时
			queue_free()



func _on_mouse_entered():
	$HighlightSprite.visible = true


func _on_mouse_exited():
	$HighlightSprite.visible = false


func _on_tree_exiting():
	if self.current_block != null:
		self.current_block.set_card(null)


func _on_shake_timer_timeout():
	self.is_shaking = false
	$Word.set_color(ImageLib.PALETTE["default"])
