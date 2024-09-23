class_name LevelMenuCamera extends Camera2D


const WIDTH := 1920 / 3
const HEIGHT := 1080 / 3
const MOVE_TIME := 0.3


func _process(_delta):
	self.position = $SmoothMovement.get_position()
	# print($SmoothMovement.get_position())

func init_position(pos: Vector2) -> void:
	$SmoothMovement.set_position(pos)


func _on_next_chapter_button_pressed():
	$SmoothMovement.move_to($SmoothMovement.get_position() + Vector2(WIDTH, 0), MOVE_TIME)


func _on_previous_chapter_button_pressed():
	$SmoothMovement.move_to($SmoothMovement.get_position() - Vector2(WIDTH, 0), MOVE_TIME)
