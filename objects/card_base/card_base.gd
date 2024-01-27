extends Area2D

class_name CardBase

const Card := preload("res://objects/card/card.tscn")

var card_count = 0
var new_card_node: Card

func update_card_count_label():
	$Label.text = str(card_count)

func _ready():
	update_card_count_label()

func add_card_count():
	card_count += 1

func inc_card_count():
	card_count += 1
	update_card_count_label()
	
	if card_count == 2:
		# TODO: 更改 texture
		pass
	elif card_count == 1:
		# TODO: 更改 texture
		pass
	
	
func dec_card_count():
	card_count -= 1
	update_card_count_label()
	
	if card_count == 1:
		# TODO: 更改 texture
		pass
	elif card_count == 0:
		# TODO: 更改 texture
		pass
	

func draw_card():
	if card_count <= 0:
		return
	dec_card_count()
	new_card_node = Card.instantiate()
	new_card_node.set_word($Word.get_word())
	new_card_node.set_position(position)
	$Cards.add_child(new_card_node)
	new_card_node.back_to_origin_global_position.connect(_on_card_back.bind(new_card_node))
	new_card_node._on_mouse_pressed()
	prints("new_card_node", new_card_node.name)
	
func _on_card_back(card: Card):
	inc_card_count()
	prints("new_card_node", card.name, "has been removed")
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
