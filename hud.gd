extends CanvasLayer

#@onready var canvas = $CanvasLayer
#@onready var tela = canvas.get_node("/root/gameManager")


func update() -> void:
	if gameManager.equip.rHand.type == "axe":
		$Control/Equip/Axe.visible = true
	


func _on_visibility_changed() -> void:
	update()
	
