extends Resource
class_name ItemClass



@export var ItemName: String
@export var Type: String
@export var Weight: int

func _init(p_ItemName: String = "", p_Type: String = "", p_Weight: int = 0) -> void:
	ItemName = p_ItemName
	Type = p_Type
	Weight = p_Weight
