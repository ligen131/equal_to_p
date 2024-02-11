extends Area2D

class_name Card

signal put
signal back_to_origin_global_position

var is_dragging = false
var have_deal_on_mouse_release = true
var origin_global_position: Vector2
var last_global_position: Vector2
var is_card_entered = 0
var entered_area: Block
var last_occupied_area: Block

var is_card_base_entered = 0
var entered_card_base_global_position: Vector2

var is_victory := false

var shake_amount : float
var is_shaking := false


func _ready():
	origin_global_position = global_position
	last_global_position = global_position
	$HighlightSprite.visible = false

func _on_mouse_release():
	#prints(entered_area.name, is_card_entered, entered_area.occupied)
	have_deal_on_mouse_release = true
	if is_card_entered > 0 and entered_area and not entered_area.occupied:
		global_position = entered_area.global_position
		last_global_position = global_position
		if last_occupied_area:
			last_occupied_area.occupied = false
		entered_area.occupied = true
		last_occupied_area = entered_area
		entered_area.set_card(self)
		emit_signal("put")
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		$SFXPutDown.play()
		# prints("card", $Word.get_word(), "put at", entered_area.name, "at global_position", global_position, "when origin global_position at", origin_global_position)
	else:
		global_position = last_global_position
	
	if global_position == origin_global_position:
		emit_signal("back_to_origin_global_position")
		
	if is_card_base_entered > 0:
		reset_position()
		
	is_dragging = false
	is_card_entered = 0
	is_card_base_entered = 0

func reset_position():
	global_position = origin_global_position
	var err := emit_signal("back_to_origin_global_position")
	if err != 0:
		printerr(err)
	last_global_position = origin_global_position
	#print(last_occupied_area)
	if last_occupied_area:
		last_occupied_area.occupied = false
		last_occupied_area = null
		
func _on_mouse_pressed():
	have_deal_on_mouse_release = false
	last_global_position = global_position
	is_dragging = true
	is_card_entered = 0
	is_card_base_entered = 0
	

func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	#prints(self, event)
	if not is_victory and event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			_on_mouse_pressed()
		elif not event.is_pressed() and is_dragging:
			_on_mouse_release()
			
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			reset_position()

func _process(_delta: float) -> void:
	if not have_deal_on_mouse_release and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_on_mouse_release()
	if is_dragging:
		have_deal_on_mouse_release = false
		global_position = get_global_mouse_position().round()
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		
	var offset := 0
	if is_shaking:
		var progress = $ShakeTimer.time_left / $ShakeTimer.wait_time * 2 * PI
		offset = int(sin(progress) * shake_amount)
	$CardBackSprite.position.x = offset
	$HighlightSprite.position.x = offset
	$Word.position.x = offset 

func on_card_entered(area: Block) -> void:
	is_card_entered += 1
	#print(is_card_entered)
	entered_area = area

func on_card_exited() -> void:
	is_card_entered -= 1

func on_card_base_entered(pos: Vector2) -> void:
	is_card_base_entered += 1
	#print(is_card_entered)
	entered_card_base_global_position = pos

func on_card_base_exited() -> void:
	is_card_base_entered -= 1
	#print(is_card_entered)

func set_word(value: String) -> void:
	$Word.set_word(value)
	var card_type := "card-%s" % ExprValidator.get_char_type_as_str(get_word()).to_lower()
	if ImageLib.PALETTE.has(card_type):
		ImageLib.update_animation(
			$CardBackSprite, 1, 3, 1, "res://objects/card/card%d.png", 
			ImageLib.PALETTE["lightblue"], ImageLib.PALETTE[card_type]
		)
	

func get_word() -> String:
	return $Word.get_word()


func shake(is_letter_red: bool, amount: float, duration: float) -> void:
	$ShakeTimer.wait_time = duration
	shake_amount = amount

	# 开启震动
	$ShakeTimer.start()
	is_shaking = true
	
	
	if is_letter_red:
		$Word.set_color(ImageLib.PALETTE["red"])
	else:
		$HighlightSprite.visible = false




func _on_mouse_entered():
	$HighlightSprite.visible = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	$HighlightSprite.visible = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func set_color(value: Color) -> void:
	$Word.set_color(value)

func set_victory(v: bool):
	if v:
		$CollisionShape2D.set_deferred("disabled", true)


func _on_shake_timer_timeout():
	is_shaking = false
	$Word.set_color(ImageLib.PALETTE["default"])
