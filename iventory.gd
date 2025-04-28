extends Node2D
class_name IventoryClass

var content: Dictionary = {}
var size: int = 2

func add(item: ItemClass) -> void:
	for i in size:
		if content.has(i):
			if content[i].item.ItemName == item.ItemName:
				content[i].amount += 1
				print("slot ", i, " ja tem ",content[i].amount, content[i].item.ItemName)
				return
			else:
				continue
			
		print("slot ", i, " disponivel")
		content[i] = {"item" :item, "amount": 1}
		return
	
	if isfull():
		print("INVENTARIO CHEIO")
		return
	
func isfull() -> bool:
	if count() == size:
		return true
	else:
		return false

func count() -> int:
	return content.size()

func list() -> void:
	for slot in content:
		print("Nome: ", content[slot].item.ItemName , " Qtd: ", content[slot].amount)
