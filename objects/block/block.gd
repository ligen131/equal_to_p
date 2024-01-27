extends Area2D

class_name Block


const SHAKE_AMOUNT := 5


var occupied := false
var quest_pos := -1

var is_shaking := false


func _on_area_entered(area: Card):
	#prints("Entered", self, name)
	if not occupied:
		area.on_card_entered(self)

func _on_area_exited(area: Card):
	#prints("Exited", self, name)
	if not occupied:
		area.on_card_exited()

func set_word(e: String) -> void:
	$Word.set_word(e)
	
func set_block_type(value: String) -> void:
	if value == "GOLDEN":
		$GoalFrameSprite.set_visible(true)
		$GoalFrameSprite.set_visible(true)
	elif value == "PIT":
		$GoalFrameSprite.set_visible(false)
		$PitSprite.set_visible(true)
	else:
		$GoalFrameSprite.set_visible(false)
		$PitSprite.set_visible(false)
		

func get_word() -> String:
	return $Word.get_word()
	
	
func _process(_delta):
	var offset := 0
	if is_shaking:
		var progress = $ShakeTimer.time_left / $ShakeTimer.wait_time * 2 * PI
		offset = int(sin(progress) * SHAKE_AMOUNT)
	$GoalFrameSprite.position.x = offset
	$PitSprite.position.x = offset 
	$Word.position.x = offset 


func shake():
	$ShakeTimer.start()
	is_shaking = true

func _on_shake_timer_timeout():
	is_shaking = false
