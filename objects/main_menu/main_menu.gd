extends AnimatedSprite2D

var ChapterMenu = preload("res://levels/chapter_menu/chapter_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	play("init")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_animation_finished():
	play("wait_for_start")


func _on_start_button_pressed():
	get_tree().root.add_child(ChapterMenu.instantiate())
	queue_free()
