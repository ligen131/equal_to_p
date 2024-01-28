extends Node2D

const ChapterMenu = preload("res://levels/chapter_menu/chapter_menu.tscn")
const BaseLevel := preload("res://levels/base_level/base_level.tscn")

signal enter_level()

func _ready():	
	$title.play("init")


func _on_start_button_pressed():
	var base_level := BaseLevel.instantiate()
	
	# print(chap_id, lvl_id)
	
	base_level.init(0, 0)
	get_tree().root.add_child(base_level)
	enter_level.emit()
	queue_free()
	#get_tree().root.add_child(ChapterMenu.instantiate())
	#queue_free()


func _on_title_animation_finished():
	$title.play("wait_for_start")
