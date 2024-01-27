extends Node2D



const LevelButton := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")

# Called when the node enters the scene tree for the first time.

@export var chapter_id : int = 0
const button_width : int = 85
const button_heigth : int = 90

func init(chap_id : int, lvl_num : int) -> void:
	print("init?")
	chapter_id = chap_id
	for level_id in range(0, lvl_num):
		print(level_id)
		var button = LevelButton.instantiate();
		var x : int = button_width * (level_id % 4) + 50
		var y : int = button_heigth * (level_id / 4) + 30
		button.init(chapter_id, level_id, Vector2(x, y), 1)
		add_child(button)

func _ready():
	#print(BaseLevel.instantiate().DATA[chapter_id])
	#var level_num : int = len(BaseLevel.instantiate().DATA[chapter_id])
	#print(level_num)
	print("why not?")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
