extends Control

@onready var texture_rect: TextureRect = $TextureRect

var item_icon: Texture2D
var tem_item: bool = false

func set_item(icon: Texture2D):
	texture_rect.texture = icon
	tem_item = true
	
func limpar_item():
	texture_rect.texture = null
	tem_item = false

# Começa o arrasto
func get_drag_data(_position):
	if not tem_item:
		return null
	
	var preview = TextureRect.new()
	preview.texture = texture_rect.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.size = Vector2(64, 64)  # ou outro tamanho
	set_drag_preview(preview)
	
	return texture_rect.texture

# Verifica se pode aceitar o drop
func can_drop_data(_position, data):
	return data is Texture2D

# Quando o item for solto aqui
func drop_data(_position, data):
	set_item(data)
