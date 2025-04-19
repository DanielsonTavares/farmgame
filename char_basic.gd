extends CharacterBody2D
class_name CharBasic

var walkDirection: String
var canAttack: bool = true
var attackAnimationName: String = ""

var iventory = IventoryClass.new()
var equip: Dictionary = {}



@export_category("Variables")
@export var moveSpeed: float = 128.0
@export var leftAttackName: String = ""
@export var rightAttackName: String = ""
@export var attackAreaCollision: CollisionShape2D


@export_category("Objects")
@export var animation = AnimatedSprite2D.new()

func _ready() -> void:
	#equip.rHand = {"type": "axe", "damage": [5,8] }
	equip.rHand = {"type": "hand", "damage": [1,1] }
	equip.lHand = {"type": "hand", "damage": [1,1] }
	
	

func _physics_process(delta: float) -> void:
	move()
	attack()
	animate()
	
	if Input.is_action_just_pressed("openIventory"):
		iventory.list()
	
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
	var attackType: Dictionary = {}
	
	if equip.rHand.type == "hand":
		return
	else:
		attackType.up = "attackUp"
		attackType.down = "attackDown"
	
	if Input.is_action_pressed("leftAttack") and canAttack:
		canAttack = false
		#attackAnimationName = leftAttackName
		
		if walkDirection == 'up':
			attackAnimationName = attackType.up
		elif walkDirection == 'down':
			attackAnimationName = attackType.down
		else:
			attackAnimationName = leftAttackName
		
		set_physics_process(false)

	if Input.is_action_pressed("rightAttack") and canAttack:
		pass
		#canAttack = false
		#attackAnimationName = rightAttackName
		#set_physics_process(false)

func equipRightHand() -> void:
	get_node("/root/Game/FarmLevel/Hud/Axe").visible = true
	

func _on_animated_sprite_2d_animation_finished() -> void:
	canAttack = true
	attackAreaCollision.disabled = true
	set_physics_process(true)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PhysicsTree:
		print("HP arvore ", body.health )
		print("dano ", equip.rHand.damage)
		body.updateHealth(equip.rHand.damage)
		
		if equip.rHand.type == "hand":
			if  [1,2,3,4,5,6,7].pick_random() == 2: #14% de chance de coletar 
				iventory.add( [body.type,1] )
				body.showLabel(1)
		elif equip.rHand.type == "axe":
			iventory.add( [body.type,1] )
			body.showLabel(1)
