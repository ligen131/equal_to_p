class_name ImageLib

const PALETTE = {
	"red": Color("#dd4132"),
	"golden": Color("#f5df4d"),
	
	"orange": Color("#ffb463"),
	"card-op": Color("#ffb463"),
	
	"lightblue": Color("#8eacf3"),
	"card-var": Color("#8eacf3"),

	"lightgreen": Color("#8ff297"),
	"card-comp": Color("#8ff297"),
	
	"sliver": Color("#f0f0f0"),
	"card-const": Color("#f0f0f0"),

	"default": Color.BLACK,
}

static func change_color(image: Texture, old_color: Color, new_color: Color) -> Texture:
	var new_texture = image.get_image()
	for x in range(new_texture.get_width()):
		for y in range(new_texture.get_height()):
			var color = new_texture.get_pixel(x, y)
			if color == old_color:
				new_texture.set_pixel(x, y, new_color)
	return ImageTexture.create_from_image(new_texture)
