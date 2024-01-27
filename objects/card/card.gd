extends Area2D

var is_dragging = false
var origin_position: Vector2

func _ready():
	origin_position = position

func _on_mouse_release():
	position = origin_position
	is_dragging = false

func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			origin_position = position
			is_dragging = true
		elif not event.is_pressed() and is_dragging:
			_on_mouse_release()

func _process(delta: float) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_on_mouse_release()
	if is_dragging:
		global_position = get_global_mouse_position()
