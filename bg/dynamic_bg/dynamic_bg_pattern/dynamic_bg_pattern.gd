extends Node2D


var velocity : Vector2


func _ready():
	if randi() % 2 == 1:
		$Word1.set_word("=*"[randi_range(0, 1)])
		$Word2.set_word("DPb>"[randi_range(0, 2)])
	else:
		$Word1.set_word("qd<"[randi_range(0, 2)])
		$Word2.set_word("=*"[randi_range(0, 1)])

func _process(delta):
	position += velocity * delta
	if position.x > 1920 / 4 + 70 or position.y < -70:
		queue_free()

func _on_victory_change(v: bool):
	$Word1.set_victory(v)
	$Word2.set_victory(v)
