## 用于检测与鼠标重合的、[member Area2D.z_index] 最高的 [Area2D]，并根据其状态设置鼠标光标形状。
class_name CursorManager extends Area2D


const CURSOR_ARROW := preload("res://ui/cursor/cursor_arrow.png") ## 鼠标光标为指针时的素材。
const CURSOR_POINTING_HAND := preload("res://ui/cursor/cursor_pointing_hand.png") ## 鼠标光标为指向时的素材。
const CURSOR_DRAG := preload("res://ui/cursor/cursor_drag.png") ## 鼠标光标为拖拽时的素材。


func _ready():
	Input.set_custom_mouse_cursor(CURSOR_ARROW)
	Input.set_custom_mouse_cursor(CURSOR_POINTING_HAND, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(CURSOR_DRAG, Input.CURSOR_DRAG)


func _process(_delta):
	self.global_position = get_global_mouse_position()

	# 获取 z_index 最高的 Area2D
	var top_area: Area2D = null
	for area in get_overlapping_areas():
		if top_area == null or area.z_index > top_area.z_index:
			top_area = area

	if top_area == null:
		Input.set_custom_mouse_cursor(CURSOR_ARROW)
	elif top_area is Card:
		if top_area.is_dragging:
			Input.set_custom_mouse_cursor(CURSOR_DRAG)
		else:
			Input.set_custom_mouse_cursor(CURSOR_POINTING_HAND)
	elif top_area is CardBase:
		if top_area.get_card_count() > 0:
			Input.set_custom_mouse_cursor(CURSOR_POINTING_HAND)
		else:
			Input.set_custom_mouse_cursor(CURSOR_ARROW)
	else:
		Input.set_custom_mouse_cursor(CURSOR_ARROW)
