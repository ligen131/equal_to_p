class_name StyledButton extends Button

@export var sfx_button_down : AudioStream


func _on_pressed():
	SoundManager.play_sfx(self.sfx_button_down)
