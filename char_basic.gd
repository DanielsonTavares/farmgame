extends CharacterBody2D
class_name CollectableTree

var walkDirection: String
var canAttack: bool = true
var attackAnimationName: String = ""

@export_category("Variables")
@export var moveSpeed: float = 128.0
@export var leftAttackName: String = ""
@export var rightAttackName: String = ""
@export var attackAreaCollision: CollisionShape2D

@export_category("Objects")
@export var animation = AnimatedSprite2D.new()


func _physics_process(delta: float) -> void:
	move()
	attack()
	animate()
	
func move() -> void:
	var direction: Vector2 = Input.get_vector(
		"moveLeft", "moveRight", "moveUp", "moveDown"
		)
	
	velocity = direction * moveSpeed
	
	move_and_slide()	

func animate() -> void:	
	if velocity.x > 0:
		animation.flip_h = false
		attackAreaCollision.position.x = 30
		walkDirection = "right"
		
	if velocity.x < 0:
		animation.flip_h = true
		attackAreaCollision.position.x = -30
		walkDirection = "left"
	
	if canAttack == false:
		animation.play(attackAnimationName)
		await get_tree().create_timer(0.3).timeout
		attackAreaCollision.disabled = false
		return

	if velocity.x:
		animation.play("walk")
		return
	
	if velocity.y < 0:
		animation.play("up")
		walkDirection = "up"
		return
		
	if velocity.y > 0:
		animation.play("down")
		walkDirection = "down"
		return
	
	if walkDirection == "left" or walkDirection == "right":
		animation.play("idleSide")
		return
	
	if walkDirection == "up":
		animation.play("idleUp")
		return
	
	animation.play("idle")

func attack() -> void:
	if Input.is_action_pressed("leftAttack") and canAttack:
		canAttack = false
		#attackAnimationName = leftAttackName
		
		if walkDirection == 'up':
			attackAnimationName = 'attackUp'
		elif walkDirection == 'down':
			attackAnimationName = 'attackDown'
		else:
			attackAnimationName = leftAttackName
		
		set_physics_process(false)

	if Input.is_action_pressed("rightAttack") and canAttack:
		pass
		#canAttack = false
		#attackAnimationName = rightAttackName
		#set_physics_process(false)


func _on_animated_sprite_2d_animation_finished() -> void:
	canAttack = true
	attackAreaCollision.disabled = true
	set_physics_process(true)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PhysicsTree:
		print("debug ", body.health )
		body.updateHealth([5,8])
	
