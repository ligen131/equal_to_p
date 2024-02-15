extends Area2D

class_name CardBase



const CardScn := preload("res://objects/card/card.tscn")
const FADE_MOVE_AMOUNT := 70



var fade_flag := false ## 是否进行淡出处理。
var is_mouse_on := false ## 鼠标是否在它的上面。


enum { DEFAULT, HIGHLIGHT, DISABLED}
var available_stat := DEFAULT ## 当前状态。


var card_count = 0 ## 剩余卡牌数量。


## 更新显示剩余卡牌数量的 Label。
func update_card_count_label():
	$Label.text = str(self.card_count)


## 设置剩余卡牌数量为 value。
func set_card_count(value):
	assert(value >= 0, "void CardBase::set_card_count(value: int) should only be called with value >= 0.")

	self.card_count = value
	if self.card_count > 0:
		if self.is_mouse_on:
			self.available_stat = HIGHLIGHT
		else:
			self.available_stat = DEFAULT
	else:
		self.available_stat = DISABLED
	update_card_count_label()


## 生成一张 Card。
##
## 当剩余卡牌数量小于等于 0 时不会生成。
func draw_card():
	if self.card_count <= 0:
		return

	set_card_count(self.card_count - 1) 
	$SFXPickUp.play()

	var new_card_node: Card = CardScn.instantiate()
	new_card_node.set_word($Word.get_word())
	new_card_node.set_position(self.position)
	
	$Cards.add_child(new_card_node)

	new_card_node.pick_up()
	

## 设置字符为 e，并更新卡背颜色。
func set_word(e: String) -> void:
	$Word.set_word(e)
	
	var card_type := "card-%s" % ExprValidator.get_char_type_as_str(e).to_lower()
	if ImageLib.PALETTE.has(card_type):
		ImageLib.update_animation($CardBaseSprite, 1, 1, 1, "res://objects/card_base/card_base%d.png", 
								  ImageLib.PALETTE["lightblue"], ImageLib.PALETTE[card_type])
	

## 获取字符。
func get_word() -> String:
	return $Word.get_word()


## 进行通关后的处理。
func set_victory() -> void:
	# 开始淡出
	fade_flag = true
	$FadeTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)
	$Label.set_visible(false)
	
	for card: Card in $Cards.get_children():
		card.set_victory(true)



func _ready():
	update_card_count_label()

			
func _process(_delta) -> void:
	var offset := 0.0
	if fade_flag:
		var progress: float = $FadeTimer.time_left / $FadeTimer.wait_time
		offset = (1 - pow(progress, 1.5)) * FADE_MOVE_AMOUNT
	$CardBaseSprite.position.y = offset
	$HighlightSprite.position.y = offset
	$DisabledSprite.position.y = offset
	$Word.position.y = offset
	
	$HighlightSprite.visible = (available_stat == HIGHLIGHT)
	$DisabledSprite.visible = (available_stat == DISABLED)

	
func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			draw_card()



func _on_mouse_entered():
	is_mouse_on = true
	if available_stat == DEFAULT:
		available_stat = HIGHLIGHT


func _on_mouse_exited():
	is_mouse_on = false
	if available_stat == HIGHLIGHT:
		available_stat = DEFAULT


func _on_cards_child_exiting_tree(node: Node) -> void:
	set_card_count(self.card_count + 1)
