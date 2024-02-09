extends Button


const WIDTH := 1920 / 4
const HEIGHT := 1080 / 4


var fade_flag := false
	

func start_fade():
	fade_flag = true
	$FadeTimer.start()

func _ready():
	position = Vector2(WIDTH / 2 - 20, HEIGHT + 80)
	$Word.set_word(">")

func _process(_delta):
	if fade_flag:
		position.y = HEIGHT + 50    - 120 * (1 - pow($FadeTimer.time_left / $FadeTimer.wait_time, 1.5))
