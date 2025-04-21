extends Area2D
class_name CollectableItem

@export_category("Variables")
@export var itemName: String = ""
@export var type: String = ""
@export var description: String = ""



@export_category("Objects")
@export var textureItem: Sprite2D
@export var info = Label



var canColect = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	#exibindo descricao do item quando o mouse passa em cima
	#info = get_node("Info")
	#info.visible = false
	#info.text = description
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		colect()
	


func _on_mouse_entered():
	modulate = Color(1, 1, 1, 0.7)  # Deixa mais transparente
	scale = Vector2(1.5,1.5)
	info.visible = true
	

func _on_mouse_exited():
	modulate = Color(1, 1, 1, 1)
	scale = Vector2(1,1)
	info.visible = false

func colect() -> void:
	if canColect:
		print("coletavel")
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "CollectableArea":
		modulate = Color(1, 1, 1, 0.7)  
		scale = Vector2(2,2)
		canColect = true


func _on_area_exited(area: Area2D) -> void:
	if area.name == "CollectableArea":
		modulate = Color(1, 1, 1, 1)  
		scale = Vector2(1,1)
		canColect = false
