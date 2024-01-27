extends Button

signal enter_level(chapter_id:int, level_id : int)

signal enter_chapter(chapter_id:int, level_num : int)

var lvl_id = 0	# 如果 type = 0 那么 lvl_id 表示的是该章节的关卡数 lvl_num
var chap_id = 0
var button_type = 0 # type = 0 表示为选择章节的按钮， type = 1 表示为选择关卡的按钮
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init(chapter_id: int, level_id : int, pos : Vector2, type : int) -> void :
	chap_id = chapter_id
	lvl_id = level_id

	if type == 0:
		text = str(chapter_id + 1)
	else:
		text = str(level_id + 1)

	position = pos
	button_type = type

func _on_pressed():
	print("choose: ",chap_id,"-",lvl_id)
	if button_type == 1:
		enter_level.emit(chap_id, lvl_id)
	else:
		enter_chapter.emit(chap_id, lvl_id)
