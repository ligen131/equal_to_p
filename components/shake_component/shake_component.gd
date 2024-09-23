## ShakeComponent 可对 ShakeComponent.attach_node: Node 的 position 应用抖动效果。
## 默认 attach_node = null，在 _ready 时设置 attach_node 为父节点。
## ShakeComponent.shake(amount: float, duration: float) 可令其抖动 duration 秒，幅度为 amount。
## 可通过 ShakeComponent.shake_type 设置抖动类型。

class_name ShakeComponent extends Node

@export var shake_type := ShakeType.H_SIN
@export var attached_node: Node = null

var progress_ratio := 1.0
var shake_amount := 0.0
var duration := 0.001

enum ShakeType {
    H_SIN, ## 水平方向正弦抖动，[code]pos_delta = Vector2(sin(progress_ratio * 2.0 * PI) * shake_amount, 0)[/code]。
}

## 返回抖动的位置偏移。
func get_position_delta():
    match self.shake_type:
        ShakeType.H_SIN:
            return Vector2(sin(progress_ratio * 2.0 * PI) * shake_amount, 0)

## 令其抖动 duration 秒，幅度为 amount。
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