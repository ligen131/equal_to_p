extends Area2D

class_name Block


const SHAKE_AMOUNT := 3.0 ## 振动时的振幅（单位为像素）。


var occupied := false ## 当 Block 上有 Card 或 Block 字符固定时，occupied 为 true。
var occupied_word := "_" ## Block 上的字符，若没有字符则为 _ 。
var occupied_card: Card = null

var quest_pos := -1 ## 在表达式中对应字符位置的下标。
var is_shaking := false ## 是否正在振动。



func _on_area_entered(area: Card):
	if not occupied:
		area.on_card_entered(self)

func _on_area_exited(area: Card):
	if not occupied:
		area.on_card_exited()

func set_word(value: String) -> void:
	$Word.set_word(value)
	if value != "_" and value != ".":
		occupied = true
		occupied_word = value
	else:
		occupied = false
		occupied_word = "_"

func set_card(c: Card) -> void:
	occupied_card = c
	occupied_word = c.get_word()
	
func set_block_type(value: String) -> void:
	if value == "GOLDEN":
		$GoalFrameSprite.set_visible(true)
		$PitSprite.set_visible(true)
	elif value == "PIT":
		$GoalFrameSprite.set_visible(false)
		$PitSprite.set_visible(true)
	else:
		$GoalFrameSprite.set_visible(false)
		$PitSprite.set_visible(false)
		

func get_word() -> String:
	return $Word.get_word()
	
	
func _process(_delta):
	var offset := 0
	if is_shaking:
		var progress = $ShakeTimer.time_left / $ShakeTimer.wait_time * 2 * PI
		offset = int(sin(progress) * SHAKE_AMOUNT)
	$GoalFrameSprite.position.x = offset
	$PitSprite.position.x = offset 
	$Word.position.x = offset 


## 开始震动。
## is_frame_red 表示是否将框改为红色。
func shake(is_frame_red: bool) -> void: 
	# 开启震动
	$ShakeTimer.start()
	is_shaking = true
	
	# 使附着的卡牌也震动
	if occupied_card != null:
		occupied_card.shake(not is_frame_red, SHAKE_AMOUNT, $ShakeTimer.wait_time) # 若框不红，则里面的字要红
	elif not is_frame_red:
		$Word.set_color(ImageLib.PALETTE["red"])
	
	if is_frame_red:
		$GoalFrameSprite.animation = "red"
	
func _on_shake_timer_timeout() -> void:
	is_shaking = false
	$GoalFrameSprite.animation = "default"
	$Word.set_color(ImageLib.PALETTE["default"])
	
func set_victory(v: bool) -> void:
	if v and occupied_card != null:
		occupied_card.set_victory(v)

func set_color(value: Color) -> void:
	if occupied_card != null:
		occupied_card.set_color(value)
	else:
		$Word.set_color(value)	
