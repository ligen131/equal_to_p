extends Panel


func _ready():
	var stylebox := get_theme_stylebox("panel")
	stylebox.texture = ImageLib.replace_palette_colors_in_image(stylebox.texture)
	add_theme_stylebox_override("panel", stylebox)
