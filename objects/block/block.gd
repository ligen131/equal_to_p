extends Area2D

func _on_area_entered(area: Card):
	area.on_area_entered(position)

func _on_area_exited(area: Card):
	area.on_area_exited()
