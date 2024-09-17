extends StyledButton

signal enter_level(chapter_id:int, level_id : int)

signal enter_chapter(chapter_id:int, level_num : int)

var lvl_id = 0	# 如果 type = 0 那么 lvl_id 表示的是该章节的关卡数 lvl_num
var chap_id = 0
var button_type = 0 # type = 0 表示为选择章节的按钮， type = 1 表示为选择关卡的按钮


func set_word(value: String) -> void:
	if value.length() == 1:
		$Word.set_word(value)
		$Word.visible = true
		$Word1.visible = false
		$Word2.visible = false
	elif value.length() == 2:
		$Word1.set_word(value[0])
		$Word2.set_word(value[1])
		$Word.visible = false
		$Word1.visible = true
		$Word2.visible = true
	else:
		push_error("level button set_word error: ", value)

func init(chapter_id: int, level_id : int, pos : Vector2, type : int) -> void :
	chap_id = chapter_id
	lvl_id = level_id

	var txt
	if type == 0:
		txt = str(chapter_id + 1)
	else:
		txt = str(level_id + 1)
	set_word(txt)

	position = pos
	button_type = type

func _on_pressed():
	# print("choose: ",chap_id,"-",lvl_id)
	# print("! ")
	SoundManager.play_sfx(self.sfx_button_down)
	if button_type == 1:
		enter_level.emit(chap_id, lvl_id)
	else:
		enter_chapter.emit(chap_id, lvl_id)
