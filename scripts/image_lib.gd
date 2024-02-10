class_name ImageLib

const PALETTE = {
	"red": Color("#dd4132"),
	"golden": Color("#f5df4d"),
	
	"orange": Color("#ffb463"),
	"card-op": Color("#ffb463"),
	
	"skyblue": Color("#c2fdff"),
	"card-bracl": Color("#c2fdff"),
	"card-bracr": Color("#c2fdff"),
	
	"lightblue": Color("#8eacf3"),
	"card-var": Color("#8eacf3"),

	"lightgreen": Color("#8ff297"),
	"card-comp": Color("#8ff297"),
	
	"sliver": Color("#f0f0f0"),
	"card-const": Color("#f0f0f0"),

	"default": Color.BLACK,
}

static func change_color(image: Texture2D, old_color: Color, new_color: Color) -> Texture2D:
	var new_texture = image.get_image()
	for x in range(new_texture.get_width()):
		for y in range(new_texture.get_height()):
			var color = new_texture.get_pixel(x, y)
			if color == old_color:
				new_texture.set_pixel(x, y, new_color)
	return ImageTexture.create_from_image(new_texture)

static func update_animation(
	sprite: AnimatedSprite2D,
	start: int,
	n: int,
	step: int, 
	path_pattern: String,
	old_color: Color,
	new_color: Color
) -> void:
	var animation_id = "%d_%d_%d_%s" % [start, n, step, new_color.to_html()]
	if not sprite.sprite_frames.has_animation(animation_id):
		sprite.sprite_frames.add_animation(animation_id)
		for i in range(n):
			var image = load(path_pattern % (i * step + start))
			sprite.sprite_frames.add_frame(animation_id, ImageLib.change_color(image, old_color, new_color))
	sprite.play(animation_id)
