extends Node2D



const BaseLevel := preload("res://levels/base_level/base_level.tscn")
const LevelButton := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")
const LevelMenu := preload("res://levels/chapter_menu/level_menu/level_menu.tscn")

# Called when the node enters the scene tree for the first time.

@export var chapter_id : int = 0
const button_width : int = 50
const button_heigth : int = 50

func init() -> void:
	var chap_num : int = len(BaseLevel.instantiate().DATA)
	for chapter_id in range(0, chap_num):
		# print(chapter_id)
		var level_num : int = len(BaseLevel.instantiate().DATA[chapter_id])
		var button = LevelButton.instantiate();
		var x : int = button_width * (chapter_id % 9) + 60
		var y : int = button_heigth * (chapter_id / 9) + 100
		button.init(chapter_id, level_num, Vector2(x, y), 0)
		button.enter_chapter.connect(_is_choose_chapter)
		add_child(button)
	

func _ready():
	print("ready")
	init()
	#print(BaseLevel.instantiate().DATA[chapter_id])
	# print(chapter_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _is_choose_chapter(chapter_id : int, level_num : int):
	var level_menu = LevelMenu.instantiate()
	level_menu.init(chapter_id, level_num)
	# print("here ready to change scene to ", chapter_id)
	get_tree().root.add_child(level_menu)
	queue_free()
