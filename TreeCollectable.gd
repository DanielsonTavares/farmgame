extends StaticBody2D
class_name PhysicsTree


var isDead: bool = false

@export_category("Variables")
@export var nameItem: String = ""
@export var health: int = 20
@export var type: String = ""
@export var itemDrop: Dictionary = {}

@export_category("Objects")
@export var animation: AnimationPlayer

func _ready() -> void:
	itemDrop = {
		"name": nameItem,
		"type": type
	}


func updateHealth(damageRange: Array) -> int:
	var damage: int = 0
	
	if isDead:
		return -1
	
	damage = randi_range(damageRange[0], damageRange[1])
	health -= damage

	if health <= 0:
		isDead = true
		animation.play("kill")
		return damage
	
	animation.play("hit")
	return damage
	


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		animation.play("idle")
	
	if anim_name == "kill":
		queue_free()
	
func showLabel(amount: int) -> void :
	if amount > 0:
		$Label.text = "+" + str(amount)
		$Label.visible = true
		await get_tree().create_timer(0.5).timeout
		$Label.visible = false
