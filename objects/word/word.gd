extends AnimatedSprite2D


@export var text_id := 1
@export var is_victory = false


const STEP := 30
const LETTER_NAME = ["_", "=", "P", "b", "D", 
"I1", "I2", "I3", "I4", "I5", 
"R", "Q", "d", "q", "(",
"*", "+", "<", ">", ")",
"0", "1", "2", "3", "4",
"5", "6", "7", "8", "9"]


## 内建，不要用。
func get_letter_id(letter: String) -> int:
	for i in range(len(LETTER_NAME)):
		if LETTER_NAME[i] == letter:
			return i + 1
	assert(false, "Letter " + letter + " not found")
	return -1
	

## 内建，不要用。
func set_text_id(value: int) -> void:
	text_id = value
	
	assert(value > 0, "text id <= 0")
	
	var animation_id = str(text_id) + str(is_victory)
	if not sprite_frames.has_animation(animation_id):
		sprite_frames.add_animation(animation_id)
		for i in range(3):
			sprite_frames.add_frame(animation_id, load_image(i * STEP + text_id, is_victory))
	animation = animation_id
	
	

## 更改字母为 text。
func set_word(text: String) -> void:
	if text == "_" or text == ".":
		set_text_id(1)
	else:
		set_text_id(get_letter_id(text))

## 获得当前字母。
func get_word() -> String:
	return LETTER_NAME[text_id - 1]


func _ready():
	set_text_id(text_id)


func _process(delta):
	if animation == "default":
		set_text_id(text_id)
		
func set_victory(v: bool):
	if v != is_victory:
		is_victory = v
		set_text_id(text_id)
		
func load_image(h: int, is_victory: bool):
	var image := load("res://objects/word/sprites/sprite" + str(h) + ".png")
	if is_victory:
		var new_texture = image.get_image()
		for x in range(new_texture.get_width()):
			for y in range(new_texture.get_height()):
				var color = new_texture.get_pixel(x, y)
				if color == Color(0, 0, 0, 1):  # 如果像素是黑色
					new_texture.set_pixel(x, y, Color.hex(0xf5df4dff))  # 将其改为金黄色
		return ImageTexture.create_from_image(new_texture)
		
	return image
