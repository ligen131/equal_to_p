class_name ShakeComponent extends Node

@export var shake_type := ShakeType.H_SIN
@export var attached_node: Node = null

var progress_ratio := 1.0
var shake_amount := 0.0
var duration := 0.001

enum ShakeType {H_SIN}

func get_position_delta():
    match self.shake_type:
        ShakeType.H_SIN:
            return Vector2(sin(progress_ratio * 2.0 * PI) * shake_amount, 0)

func shake(amount: float, duration_time: float = 0.001) -> void:
    self.progress_ratio = 0.0
    self.shake_amount = amount
    self.duration = duration_time

func _ready():
    if self.attached_node == null:
        self.attached_node = self.get_parent()

func _process(delta: float):
    if self.progress_ratio < 1.0:
        self.progress_ratio = min(1.0, self.progress_ratio + delta / self.duration)
        self.attached_node.position = self.get_position_delta()