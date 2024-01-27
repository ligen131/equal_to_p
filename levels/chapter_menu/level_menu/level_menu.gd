extends Node2D



const CHAP_NAMES = ["=P", "Add", "Multiply", "()", "Equal?"]



const LevelButton := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")
const BaseLevel := preload("res://levels/base_level/base_level.tscn")

# Called when the node enters the scene tree for the first time.

@export var chapter_id : int = 0
const button_width : int = 50
const button_heigth : int = 50

func init(chap_id : int, lvl_num : int) -> void:
	#print("init?")
	
	if lvl_num == -1:
		lvl_num = len(BaseLevel.instantiate().DATA[chap_id])
	
	$Title.set_text("Ch." + str(chap_id + 1) + "  " + CHAP_NAMES[chap_id])
	
	chapter_id = chap_id
	for level_id in range(0, lvl_num):
		#print(level_id)
		var button = LevelButton.instantiate();
		var x : int = button_width * (level_id % 9) + 60
		var y : int = button_heigth * (level_id / 9) + 100
		button.init(chapter_id, level_id, Vector2(x, y), 1)
		button.enter_level.connect(_on_button_enter_level)
		add_child(button)

func _ready():
	$BackButton/icon.play("return")
	#print(BaseLevel.instantiate().DATA[chapter_id])
	#var level_num : int = len(BaseLevel.instantiate().DATA[chapter_id])
	#print(level_num)
	#print("why not?")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_enter_level(chap_id: int, lvl_id: int) -> void:
	var base_level := BaseLevel.instantiate()
	
	# print(chap_id, lvl_id)
	
	base_level.init(chap_id, lvl_id)
	get_tree().root.add_child(base_level)
	queue_free()

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			_on_back_button_pressed()

func _on_back_button_pressed():
	var ChapterMenu = load("res://levels/chapter_menu/chapter_menu.tscn")
	var chapter_menu = ChapterMenu.instantiate()
	
	chapter_menu.init()
	get_tree().root.add_child(chapter_menu)
	queue_free()
