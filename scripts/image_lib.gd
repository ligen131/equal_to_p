class_name ImageLib


## 不同主题下的配色模板。
## [br][br]
## [code]PALETTE[theme][name]: Color[/code] 表示配色主题 [param theme] 下代号为 [param name] 的颜色值。
## [br][br]
## [param theme] 和 [param name] 的取值分别参见 [member COLOR_THEMES] 和 [member COLOR_NAMES]。
const PALETTE = {
	"blue": {
		"lightest": Color("#25acf5"),
		"light": Color("#1793e6"),
		"mid": Color("#195ba6"),
		"darkest": Color("#243966"),

		"golden": Color("#f5df4d"),
		"black": Color.BLACK,
		"red": Color("#dd4132"),
	},
	"green": {
		"lightest": Color("#94bf30"),
		"light": Color("#55b33b"),
		"mid": Color("#068051"),
		"darkest": Color("#116061"),

		"golden": Color("#f5df4d"),
		"black": Color.BLACK,
		"red": Color("#dd4132"),
	}
}


const COLOR_THEMES := ["blue", "green"] ## 可选的配色主题 [code]theme[/code] 取值。

const COLOR_NAMES := ["lightest", "light", "mid", "darkest", "golden", "black", "red"] ## 可选的颜色代号 [code]name[/code] 取值。



static var theme := "blue" ## 当前主题。



## 获取 [param color] 的主题色 [code]theme[/code] 和代号 [code]name[/code]。
## [br][br]
## 若没有在 [member PALETTE] 里出现，返回 [code]null[/code]。
## [br][br]
## 否则返回 [code][theme, name][/code]。
static func get_color_info(color: Color) -> Variant:
	for col_theme in PALETTE.keys():
		for name in PALETTE[col_theme].keys():
			if color == PALETTE[col_theme][name]:
				return [col_theme, name]
	return null


## 将 [param image] 中的 [Color] [param old_color] 替换为 [Color] [param new_color]。
static func replace_color(image: Texture2D, old_color: Color, new_color: Color) -> Texture2D:
	var new_texture = image.get_image()
	for x in range(new_texture.get_width()):
		for y in range(new_texture.get_height()):
			var color = new_texture.get_pixel(x, y)
			if color == old_color:
				new_texture.set_pixel(x, y, new_color)
	return ImageTexture.create_from_image(new_texture)


## 将 [param image] 中，在 [member PALETTE] 出现过的 [Color] 替换为当前配色主题下相同代号的 [Color]。
static func replace_palette_colors_in_image(image: Texture2D) -> Texture2D:
	var new_texture = image.get_image()
	for x in range(new_texture.get_width()):
		for y in range(new_texture.get_height()):
			var info = get_color_info(new_texture.get_pixel(x, y))
			if info != null:
				new_texture.set_pixel(x, y, PALETTE[theme][info[1]])
	return ImageTexture.create_from_image(new_texture)


static func update_animation(
	sprite: AnimatedSprite2D,
	start: int,
	n: int,
	step: int, 
	path_pattern: String,
	old_color: Color = Color.BLACK,
	new_color: Color = Color.BLACK
) -> void:
	var animation_id = "%d_%d_%d_%s_%s_%s" % [start, n, step, path_pattern, theme, new_color.to_html()]
	if not sprite.sprite_frames.has_animation(animation_id):
		sprite.sprite_frames.add_animation(animation_id)
		for i in range(n):
			var image
			if path_pattern.contains("%d"):
				image = load(path_pattern % (i * step + start))
			else:
				image = load(path_pattern)
			if old_color != new_color:
				image = ImageLib.replace_color(image, old_color, new_color)
			image = ImageLib.replace_palette_colors_in_image(image)
			sprite.sprite_frames.add_frame(animation_id, image)
	sprite.play(animation_id)


## 获取当前主题下，代号为 [param name] 的颜色值。
## [br][br]
## [param name] 的取值参见 [member COLOR_NAMES]。
static func get_palette_color_by_name(name: String) -> Color:
	return PALETTE[theme][name]	



## 获取主题 [param col_theme] 下，代号为 [param name] 的颜色值。
## [br][br]
## [param col_theme] 和 [param name] 的取值参见 [member COLOR_THEMES] 和 [member COLOR_NAMES]。
static func get_palette_color_by_info(col_theme: String, name: String) -> Color:
	return PALETTE[col_theme][name]	