## 可用于平滑移动的伪类。
## @deprecated 请使用 components/smooth_movement_component.tscn 代替。

class_name SmoothMovement extends Timer

var last_position := Vector2.ZERO
var target_position := Vector2.ZERO


enum SmoothType {
    LINEAR,
    QUAD_FADE_OUT,
    SMOOTH_STEP,
}

@export var smooth_type := SmoothType.LINEAR


static func smooth_step(v1: Vector2, v2: Vector2, t: float) -> Vector2:
    var t1 := t * t
    var t2 := 1.0 - (1.0 - t) * (1.0 - t)
    return v1.lerp(v2, lerpf(t1, t2, t))

static func quad_fade_out(v1: Vector2, v2: Vector2, t: float) -> Vector2:
    return v1.lerp(v2, 1.0 - (1.0 - t) * (1.0 - t))


func set_position(position: Vector2):
    self.last_position = position
    self.target_position = position


func move_to(target_pos: Vector2, time: float) -> void:
    self.last_position = self.target_position
    self.target_position = target_pos
    self.start(time)

func get_position() -> Vector2:
    var t := 1.0 - self.time_left / self.wait_time
    match self.smooth_type:
        SmoothType.LINEAR:
            return self.last_position.lerp(self.target_position, t)
        SmoothType.QUAD_FADE_OUT:
            return SmoothMovement.quad_fade_out(self.last_position, self.target_position, t)
        SmoothType.SMOOTH_STEP:
            return SmoothMovement.smooth_step(self.last_position, self.target_position, t)
    return Vector2.ZERO
    