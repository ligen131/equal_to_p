extends Node2D

class_name LevelMenu

# const I_NUMBER = ["I","II","III","VI","V"]

const LevelButtonScn := preload("res://levels/chapter_menu/level_menu/level_button/level_button.tscn")
const BaseLevelScn := preload("res://levels/base_level/base_level.tscn")
const CreditsScn := preload("res://objects/credits/credits.tscn")

const WIDTH := 1920 / 4

var chapter_id : int = 0
const button_width : int = 50
const button_heigth : int = 50

func init(chap_id: int) -> void:
	self.chapter_id = chap_id
	$UI/Title.text = LevelData.CHAP_NAMES[chapter_id]["name-en"]
	$LevelMenuCamera.init_position(Vector2(WIDTH * chap_id, 0))

	$UI/PreviousChapterButton.set_disabled(chapter_id == 0)
	$UI/NextChapterButton.set_disabled(chapter_id == LevelData.get_chapter_count() - 1)

func _ready():
	for cid in range(LevelData.get_chapter_count()): 
		for lid in range(LevelData.get_chapter_level_count(cid)):
			var button = LevelButtonScn.instantiate();
			var x := WIDTH * cid + button_width * (lid % 7) + 60
			var y := button_heigth * (lid / 7) + 100
			button.init(cid, lid, Vector2(x, y), 1)
			button.enter_level.connect(_on_button_enter_level)
			$LevelButtons.add_child(button)
	

func _on_button_enter_level(chap_id: int, lvl_id: int) -> void:
	var base_level := BaseLevelScn.instantiate()
	
	base_level.init(chap_id, lvl_id)
	get_tree().root.add_child(base_level)
	queue_free()


func _on_previous_chapter_button_pressed():
	self.chapter_id -= 1
	$UI/Title.text = LevelData.CHAP_NAMES[chapter_id]["name-en"]
	$UI/PreviousChapterButton.set_disabled(true)
	$UI/NextChapterButton.set_disabled(true)


func _on_next_chapter_button_pressed():
	self.chapter_id += 1
	$UI/Title.text = LevelData.CHAP_NAMES[chapter_id]["name-en"]
	$UI/PreviousChapterButton.set_disabled(true)
	$UI/NextChapterButton.set_disabled(true)

func _on_smooth_movement_timeout():
	$UI/PreviousChapterButton.set_disabled(chapter_id == 0)
	$UI/NextChapterButton.set_disabled(chapter_id == LevelData.get_chapter_count() - 1)
