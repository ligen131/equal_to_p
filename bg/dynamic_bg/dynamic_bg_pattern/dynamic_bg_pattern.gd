extends Node2D


var velocity : Vector2


func _ready():
	$Word1.set_word("=*"[randi_range(0, 1)])
	$Word2.set_word("DPb"[randi_range(0, 2)])

func _process(delta):
	position += velocity * delta
	if position.x > 1920 / 4 + 70 or position.y < -70:
		queue_free()
