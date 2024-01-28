extends Node2D


const DynamicBgPattern = preload("res://bg/dynamic_bg/dynamic_bg_pattern/dynamic_bg_pattern.tscn")


const WIDTH = 1920 / 4
const HEIGHT = 1080 / 4

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
		add_child(new_pattern)
		
		pat_x += W_STEP
		pat_y += H_STEP


func _ready():
	var x_offset = 0
	var y_offset = 0
	while HEIGHT + y_offset + (WIDTH / W_STEP) * H_STEP > -50:
		spawn(x_offset, y_offset)
		x_offset += $Timer.wait_time * VELOCITY.x
		x_offset -= int(x_offset / W_STEP) * W_STEP
		y_offset += $Timer.wait_time * VELOCITY.y
		print(y_offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	spawn(0, 0)
