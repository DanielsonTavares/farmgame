extends Node2D
class_name IventoryClass

var content: Dictionary = {}

func add(item: Array) -> void:
	
	if content.is_empty():
		content.slot1 = item
	elif content.slot1[0] != item[0]:
		print("iventario cheio cheio")
	else:
		content.slot1 = [item[0], item[1]+content.slot1[1]]

	

func count() -> int:
	return content.size()

func list() -> void:
	print("Conteudo iventario ", content)
