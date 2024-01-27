extends Area2D

class_name Card

signal put

var is_dragging = false
var origin_position: Vector2
var last_position: Vector2
var is_area_entered = 0
var entered_area: Block
var last_occupied_area: Block

func _ready():
	origin_position = position
	last_position = position

func _on_mouse_release():
	#prints(entered_area.name, is_area_entered, entered_area.occupied)
	if is_area_entered > 0 and not entered_area.occupied:
		emit_signal("put")
		position = entered_area.position
		last_position = position
		if last_occupied_area:
			last_occupied_area.occupied = false
		entered_area.occupied = true
		last_occupied_area = entered_area
	else:
		position = last_position
		
	is_dragging = false
	is_area_entered = 0

func reset_position():
	position = origin_position
	last_position = origin_position
	#print(last_occupied_area)
	if last_occupied_area:
		last_occupied_area.occupied = false
		last_occupied_area = null

func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			last_position = position
			is_dragging = true
			is_area_entered = 0
		elif not event.is_pressed() and is_dragging:
			_on_mouse_release()
			
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			reset_position()

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position()

func on_area_entered(area: Block) -> void:
	is_area_entered += 1
	#print(is_area_entered)
	entered_area = area

func on_area_exited() -> void:
	is_area_entered -= 1
	#print(is_area_entered)

func set_word(e: String) -> void:
	$Word.set_word(e)
