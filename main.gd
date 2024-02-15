class_name Main extends Node



func _on_main_menu_enter_level():
	$BGMPlayer.play()


func _on_bgm_player_finished():
	$BGMPlayer.play()
func set_victory(v: bool):
	$Bg/DynamicBg.set_victory(v)
