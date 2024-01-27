extends Area2D

class_name Block


signal word_set(quest_pos: int, word: String)


var occupied := false
var quest_pos := -1

func _on_area_entered(area: Card):
	#prints("Entered", self, name)
	if not occupied:
		area.on_card_entered(self)

func _on_area_exited(area: Card):
	#prints("Exited", self, name)
	if not occupied:
		area.on_card_exited()

func set_word(e: String) -> void:
	$Word.set_word(e)
	emit_signal("word_set", quest_pos, e)

func get_word() -> String:
	return $Word.get_word()
