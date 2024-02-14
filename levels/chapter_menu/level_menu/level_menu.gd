extends Node2D

class_name LevelMenu

# const I_NUMBER = ["I","II","III","VI","V"]

const LevelButtonScn := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")
const BaseLevelScn := preload("res://levels/base_level/base_level.tscn")
const CreditsScn := preload("res://objects/credits/credits.tscn")

@export var chapter_id : int = 0
const button_width : int = 50
const button_heigth : int = 50

func init(chap_id : int, lvl_num : int) -> void:
	if chap_id == LevelData.get_chapter_count():
		add_child(CreditsScn.instantiate())
		$Title.set_text("")
		return
		
	
	if lvl_num == -1:
		lvl_num = LevelData.get_chapter_level_count(chap_id)
	
	$Title.set_text(LevelData.CHAP_NAMES[chap_id]["name-en"])
	
	chapter_id = chap_id
	for level_id in range(0, lvl_num):
		#print(level_id)
		var button = LevelButtonScn.instantiate();
		var x : int = button_width * (level_id % 7) + 60
		var y : int = button_heigth * (level_id / 7) + 100
		button.init(chapter_id, level_id, Vector2(x, y), 1)
		button.enter_level.connect(_on_button_enter_level)
		add_child(button)

func _ready():
	$BackButton/icon.play("return")
	pass


func _on_button_enter_level(chap_id: int, lvl_id: int) -> void:
	var base_level := BaseLevelScn.instantiate()
	
	base_level.init(chap_id, lvl_id)
	get_tree().root.add_child(base_level)
	queue_free()

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			_on_back_button_pressed()

func _on_back_button_pressed():
	var ChapterMenuScn = load("res://levels/chapter_menu/chapter_menu.tscn")
	var chapter_menu = ChapterMenuScn.instantiate()
	
	chapter_menu.init()
	get_tree().root.add_child(chapter_menu)
	queue_free()
