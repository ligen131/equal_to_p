extends Node2D


var velocity : Vector2


func _ready():
	if randi() % 2 == 1:
		$Word1.set_word("=*"[randi_range(0, 1)])
		$Word2.set_word("DPb>"[randi_range(0, 2)])
	else:
		$Word1.set_word("qd<"[randi_range(0, 2)])
		$Word2.set_word("=*"[randi_range(0, 1)])
	$Word1.set_color(ImageLib.get_palette_color_by_info("blue", "mid"))
	$Word2.set_color(ImageLib.get_palette_color_by_info("blue", "mid"))

func _process(delta):
	position += velocity * delta
	if position.x > 1920 / 3 + 70 or position.y < -70:
		queue_free()

func _on_victory_change(v: bool):
	if v:
		$Word1.set_color(ImageLib.get_palette_color_by_info("blue", "light"))
		$Word2.set_color(ImageLib.get_palette_color_by_info("blue", "light"))
	else:
		$Word1.set_color(ImageLib.get_palette_color_by_info("blue", "mid"))
		$Word2.set_color(ImageLib.get_palette_color_by_info("blue", "mid"))

