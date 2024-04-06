extends PanelContainer

@onready var qnt = $ItemPanel/qnt
@onready var texture_rect = $ItemPanel/TextureRect
@onready var desc = $ItemPanel/description

func set_slot_data(Resource, numero) -> void:
	texture_rect.texture = Resource.texture
	desc.text = Resource.description
	qnt.text = str(numero)
	

