extends Area2D
class_name AxeWood


func _on_body_entered(body: Node2D) -> void:
	if body is CharBasic:
		gameManager.equip.rHand = {"type": "axeWood", "damage": [5,8], "group": "Weapon"  }
		get_node("/root/Game/FarmLevel/Hud").update()
		queue_free()
