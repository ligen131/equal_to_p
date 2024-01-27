extends Area2D

class_name CardBase

const Card := preload("res://objects/card/card.tscn")
const FADE_MOVE_AMOUNT := 70

signal card_put


var fade_flag := false


var card_count = 0
var new_card_node: Card

func update_card_count_label():
	$Label.text = str(card_count)

func _ready():
	update_card_count_label()

func set_card_count(value):
	card_count = value
	if card_count == 2:
		$AnimatedSprite2D.animation = "default"
	elif card_count == 1:
		# TODO: 更改 texture
		$AnimatedSprite2D.animation = "default"
	elif card_count == 0:
		$AnimatedSprite2D.animation = "disabled"
	update_card_count_label()


func draw_card():
	if card_count <= 0:
		return
	set_card_count(card_count - 1) 
	$SFXPickUp.play()
	new_card_node = Card.instantiate()
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
	
func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			draw_card()

func set_word(e: String) -> void:
	$Word.set_word(e)

func _on_card_put():
	emit_signal("card_put")





func start_fade() -> void:
	fade_flag = true
	$FadeTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)
	$Label.set_visible(false)

func _process(delta) -> void:
	if fade_flag:
		var offset = $FadeTimer.time_left / $FadeTimer.wait_time
		offset = (1 - pow(offset, 1.5)) * FADE_MOVE_AMOUNT
		$AnimatedSprite2D.position.y = offset
		$Word.position.y = offset
