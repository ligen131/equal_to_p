extends Sprite2D

var letter := ""

func _can_drop_data(position, data):
	return letter == ""

func _drop_data(position, data: Object):
	letter = data.letter
	data.call("queue_free")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
