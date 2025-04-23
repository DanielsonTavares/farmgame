extends CanvasLayer

#@onready var canvas = $CanvasLayer
#@onready var tela = canvas.get_node("/root/gameManager")
@onready var rightHandIcon: Sprite2D = $Control/Equip/Axe


func update() -> void:
	rightHandIcon.visible = true
	if gameManager.equip.rHand.type == "axeWood":
		rightHandIcon.region_rect = Rect2(0.0, 0.0, 16.0, 32.0)
		#$Control/Equip/Axe.region_rect = Rect2(48.0, 16.0, 16.0, 32.0)
	if gameManager.equip.rHand.type == "AxeBone":
		rightHandIcon.region_rect = Rect2(0.0, 32.0, 16.0, 32.0)

func _on_visibility_changed() -> void:
	update()
	
