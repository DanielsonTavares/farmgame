extends Area2D
class_name AxeWood


func _on_body_entered(body: Node2D) -> void:
	if body is CharBasic:
		print("debug 1 ", body.name)
		body.equip.rHand = {"type": "axe", "damage": [5,8] }
		body.equipRightHand()
		queue_free()
