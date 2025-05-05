extends Control

@onready var grid = $Panel/SlotGrid
@export var slot_count: int = 12
@export var colunas: int = 4

@export var icones_disponiveis: Array[Texture2D]  # defina no Inspector

func _ready():
	grid.columns = colunas
	for i in range(slot_count):
		var slot = preload("res://UI/Slot.tscn").instantiate()
		grid.add_child(slot)
		
	# Preenche alguns itens de teste
	for i in range(min(icones_disponiveis.size(), slot_count)):
		var slot = grid.get_child(i)
		slot.set_item(icones_disponiveis[i])
		
