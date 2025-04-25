extends CanvasLayer

#@onready var canvas = $CanvasLayer
#@onready var tela = canvas.get_node("/root/gameManager")
@onready var rightHandIcon: Sprite2D = $Control/Equip/RightHandIcon


func update(texture: Dictionary) -> void:
	rightHandIcon.visible = true
	rightHandIcon.region_rect = texture.rect

func _on_visibility_changed() -> void:
	update({})
	
