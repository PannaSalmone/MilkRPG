extends Button

@onready var qnt = $ItemPanel/qnt
@onready var texture_rect = $ItemPanel/TextureRect
@onready var obj_name = $ItemPanel/name
var desc := ""

func _ready() -> void:
	pass

func set_slot_data(Resource, numero) -> void:
	texture_rect.texture = Resource.texture
	obj_name.text = Resource.name
	qnt.text = str(numero)
	desc = Resource.description

func _on_focus_entered() -> void:
	get_parent().desc_update(desc)

func _on_pressed() -> void:
	get_parent().focus_on_use()
