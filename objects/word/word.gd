extends Sprite2D

var is_dragging = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(event, position, texture.get_width())
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			var w = texture.get_width() * scale.x
			var h = texture.get_height() * scale.y
			var x = position.x
			var y = position.y
			var rect = Rect2(x-w/2, y-h/2, x+w/2, y+h/2)
			
			if rect.has_point(mouse_pos):
				is_dragging = true
		elif not event.is_pressed() and is_dragging:
			is_dragging = false

func _process(delta) -> void:
	if is_dragging:
		global_position = get_global_mouse_position()
