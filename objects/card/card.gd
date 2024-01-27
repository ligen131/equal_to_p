extends Area2D

class_name Card

signal put
signal back_to_origin_global_position

var is_dragging = false
var origin_global_position: Vector2
var last_global_position: Vector2
var is_card_entered = 0
var entered_area: Block
var last_occupied_area: Block

var is_card_base_entered = 0
var entered_card_base_global_position: Vector2

func _ready():
	origin_global_position = global_position
	last_global_position = global_position

func _on_mouse_release():
	#prints(entered_area.name, is_card_entered, entered_area.occupied)
	if is_card_entered > 0 and entered_area and not entered_area.occupied:
		emit_signal("put")
		global_position = entered_area.global_position
		last_global_position = global_position
		if last_occupied_area:
			last_occupied_area.occupied = false
		entered_area.occupied = true
		last_occupied_area = entered_area
		entered_area.occupied_word = $Word.get_word()
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
	last_global_position = global_position
	is_dragging = true
	is_card_entered = 0
	is_card_base_entered = 0
	

func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	#prints(self, event)
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			_on_mouse_pressed()
		elif not event.is_pressed() and is_dragging:
			_on_mouse_release()
			
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			reset_position()

func _process(delta: float) -> void:
	#prints(name, global_position)
	if is_dragging:
		global_position = get_global_mouse_position()

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

func set_word(e: String) -> void:
	$Word.set_word(e)

func get_word() -> String:
	return $Word.get_word()
