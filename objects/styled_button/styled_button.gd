extends Button

class_name StyledButton


func _on_pressed():
	$SFXButtonDown.play()


func _ready():
	for box_theme in ["normal", "hover", "presssed", "disabled", "focus"]:
		var stylebox := get_theme_stylebox(box_theme)
		if stylebox is StyleBoxTexture:
			stylebox.texture = ImageLib.replace_palette_colors_in_image(stylebox.texture)
			add_theme_stylebox_override(box_theme, stylebox)
