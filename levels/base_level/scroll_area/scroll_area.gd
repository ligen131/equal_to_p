extends Area2D


const WIDTH := 1920 / 4
const PADDING := 32
const SPEED := 300


@export var is_on_left := true

var is_mouse_on = false



func _process(delta: float):
	if self.is_mouse_on:
		if get_tree().root.has_node("BaseLevel/HUDs/TableCloth"):
			var table_cloth_node = get_tree().root.get_node("BaseLevel/HUDs/TableCloth")
			var offset := 0

			if table_cloth_node.size.x < WIDTH:
				return

			if self.is_on_left and table_cloth_node.position.x < PADDING:
				offset = min(PADDING - table_cloth_node.position.x, int(delta * SPEED + 0.5))
			elif not self.is_on_left and table_cloth_node.position.x + table_cloth_node.size.x > WIDTH - PADDING:
				offset = -min(table_cloth_node.position.x + table_cloth_node.size.x - (WIDTH - PADDING), int(delta * SPEED + 0.5))
				
			if offset != 0:
				table_cloth_node.position.x += offset
				for block: Block in get_tree().root.get_node("BaseLevel/Blocks").get_children():
					block.position.x += offset
					if block.occupied_card != null:
						block.occupied_card.position.x += offset


func _on_mouse_exited():
	self.is_mouse_on = false

func _on_mouse_entered():
	self.is_mouse_on = true
