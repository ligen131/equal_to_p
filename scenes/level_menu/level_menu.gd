extends Node2D

class_name LevelMenu


const LevelButtonScn := preload("res://scenes/level_menu/level_button/level_button.tscn")
const BaseLevelScn := preload("res://scenes/base_level/base_level.tscn")
const CreditsScn := preload("res://scenes/credits/credits.tscn")

const WIDTH := 1920 / 3

var chapter_id: int = 0
const button_width: int = 50
const button_heigth: int = 50

func init(chap_id: int) -> void:
	self.chapter_id = chap_id
	$UI/Title.text = tr("CHAPTER_PATTERN") % [chap_id + 1, tr("CHAPTER_NAME_%d" % chap_id)]
	$LevelMenuCamera.init_position(Vector2(WIDTH * chap_id, 0))

	$UI/PreviousChapterButton.visible = (chapter_id != 0)
	$UI/NextChapterButton.disabled = (chapter_id == LevelData.get_chapter_count() - 1 or not LevelData.is_chapter_unlocked(chapter_id + 1))
	$UI/NextChapterButton.visible = (chapter_id != LevelData.get_chapter_count() - 1)

func _ready():
	for cid in range(LevelData.get_chapter_count()):
		for lid in range(LevelData.get_chapter_level_count(cid)):
			var button: Button = LevelButtonScn.instantiate()
			$LevelButtons.add_child(button)

			var x := WIDTH * cid + button_width * (lid % 7) + 60
			var y := button_heigth * (lid / 7) + 100
			button.init(cid, lid, Vector2(x, y), 1)
			button.enter_level.connect(_on_button_enter_level)
			button.disabled = (lid >= 1 and not SaveLib.is_level_cleared(cid, lid - 1))
	

func _on_button_enter_level(chap_id: int, lvl_id: int) -> void:
	var base_level := BaseLevelScn.instantiate()
	
	base_level.init(chap_id, lvl_id)
	get_tree().root.add_child(base_level)
	queue_free()


func _on_previous_chapter_button_pressed():
	self.chapter_id -= 1
	$UI/Title.text = tr("CHAPTER_PATTERN") % [self.chapter_id + 1, tr("CHAPTER_NAME_%d" % self.chapter_id)]
	ImageLib.change_theme(ImageLib.COLOR_THEMES[ImageLib.COLOR_THEMES.find(ImageLib.theme_to) - 1], LevelMenuCamera.MOVE_TIME)
	$UI/PreviousChapterButton.disabled = true
	$UI/PreviousChapterButton.visible = (chapter_id != 0)
	$UI/NextChapterButton.disabled = true
	$UI/NextChapterButton.visible = (chapter_id != LevelData.get_chapter_count() - 1)


func _on_next_chapter_button_pressed():
	self.chapter_id += 1
	ImageLib.change_theme(ImageLib.COLOR_THEMES[ImageLib.COLOR_THEMES.find(ImageLib.theme_to) + 1], LevelMenuCamera.MOVE_TIME)
	$UI/Title.text = tr("CHAPTER_PATTERN") % [self.chapter_id + 1, tr("CHAPTER_NAME_%d" % self.chapter_id)]
	$UI/PreviousChapterButton.disabled = true
	$UI/PreviousChapterButton.visible = (chapter_id != 0)
	$UI/NextChapterButton.disabled = true
	$UI/NextChapterButton.visible = (chapter_id != LevelData.get_chapter_count() - 1)

func _on_smooth_movement_timeout():
	$UI/PreviousChapterButton.disabled = false
	$UI/NextChapterButton.disabled = (chapter_id == LevelData.get_chapter_count() - 1 or not LevelData.is_chapter_unlocked(chapter_id + 1))


func _on_debug_unlock_button_pressed() -> void:
	for i in range(LevelData.get_chapter_count()):
		for j in range(LevelData.get_chapter_level_count(i)):
			SaveLib.set_level_cleared(i, j, true)

func _on_debug_reset_button_pressed() -> void:
	for i in range(LevelData.get_chapter_count()):
		for j in range(LevelData.get_chapter_level_count(i)):
			SaveLib.set_level_cleared(i, j, false)