## 可将父节点从一个位置平滑移动到另一个位置的组件。
## [br][br]
## 会强制修改父节点的位置。
## [br][br]
## 用 [method move_to] 或 [method move_from_to] 方法来移动父节点。
## [br][br]
## 用 [method get_position] 方法来获取当前位置。
## [br][br]
## 设置 [member smooth_type] 属性可改变平滑方式。

class_name SmoothMovementComponent extends Node

@export var smooth_type := SmoothType.LINEAR ## 平滑移动的方式。

@onready var _parent = get_parent()

var _start_position := Vector2.ZERO
var _end_position := Vector2.ZERO
var _progress_ratio := 0.0
var _duration := 0.001


enum SmoothType {
	LINEAR,
	QUAD_FADE_OUT,
	SMOOTH_STEP,
}


static func _linear(v1: Vector2, v2: Vector2, t: float) -> Vector2:
	return v1.lerp(v2, t)

static func _smooth_step(v1: Vector2, v2: Vector2, t: float) -> Vector2:
	var t1 := t * t
	var t2 := 1.0 - (1.0 - t) * (1.0 - t)
	return v1.lerp(v2, lerpf(t1, t2, t))

static func _quad_fade_out(v1: Vector2, v2: Vector2, t: float) -> Vector2:
	return v1.lerp(v2, 1.0 - (1.0 - t) * (1.0 - t))


## 设置父节点的位置为 [param position] 并停止移动。
func set_position(position: Vector2):
	self._start_position = position
	self._end_position = position

## 将父节点从当前位置平滑移动到 [param target_position]，耗时 [param duration_time] 秒。
func move_to(target_position: Vector2, duration_time: float = 0.001) -> void:
	self._start_position = self.get_position()
	self._end_position = target_position
	self._progress_ratio = 0.0
	self._duration = duration_time

## 将父节点从 [param begin_position] 平滑移动到 [param target_position]，耗时 [param duration_time] 秒。
func move_from_to(begin_position: Vector2, target_position: Vector2, duration_time: float = 0.001) -> void:
	self._start_position = begin_position
	self._end_position = target_position
	self._progress_ratio = 0.0
	self._duration = duration_time

## 获取当前位置。
func get_position() -> Vector2:
	match self.smooth_type:
		SmoothType.LINEAR:
			return SmoothMovementComponent._linear(self._start_position, self._end_position, _progress_ratio)
		SmoothType.QUAD_FADE_OUT:
			return SmoothMovementComponent._quad_fade_out(self._start_position, self._end_position, _progress_ratio)
		SmoothType.SMOOTH_STEP:
			return SmoothMovementComponent._smooth_step(self._start_position, self._end_position, _progress_ratio)
	return Vector2.ZERO


func _ready():
	self._start_position = self._parent.position
	self._end_position = self._parent.position

func _process(_delta):
	if self._progress_ratio < 1.0:
		self._progress_ratio = min(1.0, self._progress_ratio + _delta / self._duration)
		self._parent.set_position(Vector2i(self.get_position()))
