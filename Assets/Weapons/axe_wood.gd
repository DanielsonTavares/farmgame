extends Area2D
class_name AxeWood


func _on_body_entered(body: Node2D) -> void:
	if body is CharBasic:
		print("debug 1 ", body.name)
		gameManager.equip.rHand = {"type": "axe", "damage": [5,8] }
		get_node("/root/Game/FarmLevel/Hud").update()
		queue_free()
