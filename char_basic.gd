extends CharacterBody2D
class_name CharBasic

var walkDirection: String
var canAttack: bool = true
var attackAnimationName: String = ""

var iventory = IventoryClass.new()


@onready var HudInventory = get_node("/root/Game/FarmLevel/Hud/Control")

@export_category("Variables")
@export var moveSpeed: float = 128.0
@export var leftAttackName: String = ""
@export var rightAttackName: String = ""
@export var attackAreaCollision: CollisionShape2D


@export_category("Objects")
@export var animation = AnimatedSprite2D.new()

func _ready() -> void:
	#equip.rHand = {"type": "axe", "damage": [5,8] }
	gameManager.equip.rHand = {"type": "hand", "damage": [1,1], "group": "Weapon" }
	gameManager.equip.lHand = {"type": "hand", "damage": [1,1], "group": "Weapon"  }
	

	

func _physics_process(delta: float) -> void:
	move()
	attack()
	animate()
	
	if Input.is_action_just_pressed("openIventory"):
		iventory.list()

		if gameManager.isInventoryOpen == false:
			HudInventory.visible = true
		else:
			HudInventory.visible = false
		
		gameManager.isInventoryOpen = not gameManager.isInventoryOpen
	

		
	
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
	
	if gameManager.equip.rHand.type == "hand":
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


	

func _on_animated_sprite_2d_animation_finished() -> void:
	canAttack = true
	attackAreaCollision.disabled = true
	set_physics_process(true)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	var damageHit: int = 0
	
	if body is PhysicsTree:
		print("HP arvore ", body.health )
		print("dano ", gameManager.equip.rHand.damage)
		damageHit = body.updateHealth(gameManager.equip.rHand.damage)
		
		if gameManager.equip.rHand.type == "hand":
			if  [1,2,3,4,5,6,7].pick_random() == 2: #14% de chance de coletar 
				iventory.add( [body.type,1] )
				body.showLabel(damageHit)
		elif gameManager.equip.rHand.group == "Weapon":
			iventory.add( [body.type,1] )
			body.showLabel(damageHit)






func _on_collectable_area_area_entered(area: Area2D) -> void:
	if area is CollectableItem:
		area.colect()
