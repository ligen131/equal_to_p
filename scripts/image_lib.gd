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


## 为 [AnimatedSprite2D] [param sprite] 生成动画并播放。
## [br][br]
## 动画图像的路径模式串为 [param path_pattern]，应当为仅带一个 [code]%d[/code] 的模式串或常量串。[param start] 为起始帧编号，[param n] 为帧的数量，[param step] 为每帧之间编号的差值。
## [br][br]
## 图像会按照 [code]path_pattern % (i * step + start)[/code] 进行加载，其中 [code]i in range(n)[/code]。
## [br][br]
## 加载时，会先将图像里的所有 [Color] [param old_color] 替换为 [Color] [param new_color]，再将 [member PALETTE] 里出现的 [Color] 替换为当前配色主题下相同代号的 [Color]。
## [br][br]
## 示例：
## [codeblock]
## # 载入 res://image2.png, res://image22.png, res://image42.png 作为动画，设置 self 播放。
## # 载入时，先将图片中的白色替换为红色，再将 PALETTE 中出现的颜色替换为当前主题下的同名色。
## update_animation(self, 2, 3, 20, "res://image%d.png", Color.WHITE, Color.RED)
## [/codeblock]
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
