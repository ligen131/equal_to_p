extends ColorRect

signal victory_change(v: bool)

const DynamicBgPattern = preload("res://bg/dynamic_bg/dynamic_bg_pattern/dynamic_bg_pattern.tscn")

var is_victory = false

const WIDTH = 1920 / 3
const HEIGHT = 1080 / 3

const W_STEP := 60
const H_STEP := 6

var VELOCITY = 30 * Vector2.from_angle(-atan(2))

func spawn(x_offset, y_offset):
	var pat_x = -WIDTH + x_offset
	var pat_y = HEIGHT + y_offset
	
	while pat_x < WIDTH + 50:
		var new_pattern = DynamicBgPattern.instantiate()
		
		new_pattern.position = Vector2(pat_x, pat_y)
		new_pattern.velocity = VELOCITY
		victory_change.connect(new_pattern._on_victory_change)
		add_child(new_pattern)
		new_pattern._on_victory_change(is_victory)
		
		pat_x += W_STEP
		pat_y += H_STEP

func set_victory(v: bool):
	if is_victory != v:
		is_victory = v
		victory_change.emit(v)

func _ready():
	var x_offset = 0
	var y_offset = 0
	self.color = ImageLib.get_palette_color_by_info("blue", "darkest")
	
	while HEIGHT + y_offset + (WIDTH / W_STEP) * H_STEP > -50:
		spawn(x_offset, y_offset)
		x_offset += $Timer.wait_time * VELOCITY.x
		x_offset -= int(x_offset / W_STEP) * W_STEP
		y_offset += $Timer.wait_time * VELOCITY.y


func _on_timer_timeout():
	spawn(0, 0)
