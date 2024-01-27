extends Area2D

class_name Block

var occupied = false

func _on_area_entered(area: Card):
	#prints("Entered", self, name)
	if not occupied:
		area.on_area_entered(self)

func _on_area_exited(area: Card):
	#prints("Exited", self, name)
	if not occupied:
		area.on_area_exited()

func set_word(e: String) -> void:
	$Word.set_word(e)

func get_word() -> String:
	return $Word.get_word()
