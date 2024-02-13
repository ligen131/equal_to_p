extends Area2D

class_name CardBase

const CardScn := preload("res://objects/card/card.tscn")
const FADE_MOVE_AMOUNT := 70

signal card_put


var fade_flag := false
var mouse_on := false

enum { DEFAULT, HIGHLIGHT, DISABLED}
var available_stat := DEFAULT


var card_count = 0
var new_card_node: Card

func update_card_count_label():
	$Label.text = str(card_count)

func _ready():
	update_card_count_label()

func set_card_count(value):
	card_count = value
	if card_count > 0:
		if mouse_on:
			available_stat = HIGHLIGHT
		else:
			available_stat = DEFAULT
	else:
		available_stat = DISABLED
	update_card_count_label()


func draw_card():
	if card_count <= 0:
		return
	set_card_count(card_count - 1) 
	$SFXPickUp.play()
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	new_card_node = CardScn.instantiate()
	new_card_node.set_word($Word.get_word())
	new_card_node.set_position(position)
	$Cards.add_child(new_card_node)
	new_card_node.back_to_origin_global_position.connect(_on_card_back.bind(new_card_node))
	new_card_node.put.connect(_on_card_put)

	new_card_node._on_mouse_pressed()
	# prints("new_card_node", new_card_node.name)
	
func _on_card_back(card: Card):
	set_card_count(card_count + 1)
	# prints("new_card_node", card.name, "has been removed")
	$Cards.remove_child(card)
	card.queue_free()
	#print("card_count = ", card_count)

func _on_area_entered(area: Card):
	#prints("Entered", name)
	if area.get_word() == $Word.get_word():
		area.on_card_base_entered(position)

func _on_area_exited(area: Card):
	#prints("Exited", name)
	if area.get_word() == $Word.get_word():
		area.on_card_base_exited()
	
func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			draw_card()

func set_word(e: String) -> void:
	$Word.set_word(e)
	
	var card_type := "card-%s" % ExprValidator.get_char_type_as_str(e).to_lower()
	if ImageLib.PALETTE.has(card_type):
		ImageLib.update_animation($CardBaseSprite, 1, 1, 1, "res://objects/card_base/card_base%d.png", 
								  ImageLib.PALETTE["lightblue"], ImageLib.PALETTE[card_type])
	
func get_word() -> String:
	return $Word.get_word()

func _on_card_put():
	emit_signal("card_put")

func set_victory() -> void:
	# start_fade
	fade_flag = true
	$FadeTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)
	$Label.set_visible(false)
	
	for card: Card in $Cards.get_children():
		card.set_victory(true)

func reset_all_card_position():
	for card: Card in $Cards.get_children():
		card.reset_position()

func _process(_delta) -> void:
	if fade_flag:
		var offset = $FadeTimer.time_left / $FadeTimer.wait_time
		offset = (1 - pow(offset, 1.5)) * FADE_MOVE_AMOUNT
		$CardBaseSprite.position.y = offset
		$HighlightSprite.position.y = offset
		$DisabledSprite.position.y = offset
		$Word.position.y = offset
	
	$HighlightSprite.visible = (available_stat == HIGHLIGHT)
	$DisabledSprite.visible = (available_stat == DISABLED)


func _on_mouse_entered():
	mouse_on = true
	if available_stat == DEFAULT:
		available_stat = HIGHLIGHT
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	mouse_on = false
	if available_stat == HIGHLIGHT:
		available_stat = DEFAULT
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
