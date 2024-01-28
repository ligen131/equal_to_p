extends Node2D

const ChapterMenu = preload("res://levels/chapter_menu/chapter_menu.tscn")
const BaseLevel := preload("res://levels/base_level/base_level.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$title.play("init")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_finished():
	$title.play("wait_for_start")


func _on_start_button_pressed():
	var base_level := BaseLevel.instantiate()
	
	# print(chap_id, lvl_id)
	
	base_level.init(0, 0)
	get_tree().root.add_child(base_level)
	queue_free()
	#get_tree().root.add_child(ChapterMenu.instantiate())
	#queue_free()
