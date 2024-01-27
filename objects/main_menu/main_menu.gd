extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_animation_finished():
	play("wait_for_start")
	pass # Replace with function body.
