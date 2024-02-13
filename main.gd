extends Node


const CURSOR_ARROW := preload("res://bg/cursor/cursor_arrow.png")
const CURSOR_POINTING_HAND := preload("res://bg/cursor/cursor_pointing_hand.png")
const CURSOR_DRAG := preload("res://bg/cursor/cursor_drag.png")


func _ready():	
	Input.set_custom_mouse_cursor(CURSOR_ARROW, Input.CURSOR_ARROW, Vector2(0, 5))
	Input.set_custom_mouse_cursor(CURSOR_POINTING_HAND, Input.CURSOR_POINTING_HAND, Vector2(0, 5))
	Input.set_custom_mouse_cursor(CURSOR_DRAG, Input.CURSOR_DRAG, Vector2(0, 5))


func _on_main_menu_enter_level():
	$BGMPlayer.play()


func _on_bgm_player_finished():
	$BGMPlayer.play()
func set_victory(v: bool):
	$Bg/DynamicBg.set_victory(v)
