extends Node2D

class_name ChapterMenu

const BaseLevelScn := preload("res://levels/base_level/base_level.tscn")
const LevelButtonScn := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")
const LevelMenuScn := preload("res://levels/chapter_menu/level_menu/level_menu.tscn")

# Called when the node enters the scene tree for the first time.

@export var chapter_id : int = 0
const button_width : int = 50
const button_heigth : int = 50

func init() -> void:
	var chap_num : int = len(BaseLevelScn.instantiate().DATA)
	for lvl_id in range(0, chap_num):
		# print(lvl_id)
		var level_num : int = len(BaseLevelScn.instantiate().DATA[lvl_id])
		var button = LevelButtonScn.instantiate();
		var x : int = button_width * (lvl_id % 9) + 60
		var y : int = button_heigth * (lvl_id / 9) + 100
		button.init(lvl_id, level_num, Vector2(x, y), 0)
		button.enter_chapter.connect(_is_choose_chapter)
		add_child(button)
	

func _ready():
	# print("ready")
	init()
	#print(BaseLevelScn.instantiate().DATA[chapter_id])
	# print(chapter_num)


func _is_choose_chapter(chap_id : int, level_num : int):
	var level_menu = LevelMenuScn.instantiate()
	level_menu.init(chap_id, level_num)
	# print("here ready to change scene to ", chapter_id)
	get_tree().root.add_child(level_menu)
	queue_free()
