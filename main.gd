extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_main_menu_enter_level():
	$BGMPlayer.play()


func _on_bgm_player_finished():
	$BGMPlayer.play()
func set_victory(v: bool):
	$Bg/DynamicBg.set_victory(v)
