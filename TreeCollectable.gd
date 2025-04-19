extends StaticBody2D
class_name PhysicsTree

var tipo: String = "carvalho"
var isDead: bool = false

@export_category("Variables")
@export var health: int = 20
@export var type: String = "tronco"

@export_category("Objects")
@export var animation: AnimationPlayer


func updateHealth(damageRange: Array) -> void:
	if isDead:
		return
		
	health -= randi_range(damageRange[0], damageRange[1])

	if health <= 0:
		isDead = true
		animation.play("kill")
		return
	
	animation.play("hit")
	


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		animation.play("idle")
	
	if anim_name == "kill":
		queue_free()
	
func showLabel(amount: int) -> void :
	$Label.text = "+" + str(amount)
	$Label.visible = true
	await get_tree().create_timer(0.5).timeout
	$Label.visible = false
	pass
