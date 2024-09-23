extends Label

func _process(_delta):
	get_tree().current_scene.set_victory(true)

func _exit_tree():
	get_tree().current_scene.set_victory(false)
