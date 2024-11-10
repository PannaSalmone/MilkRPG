extends Button

@onready var qnt = $ItemPanel/qnt
@onready var texture_rect = $ItemPanel/TextureRect
@onready var obj_name = $ItemPanel/name
var item_name : String
var desc := ""

func _ready() -> void:
	pass

func set_slot_data(res, numero) -> void:
	texture_rect.texture = res.icon
	obj_name.text = res.name
	item_name = res.name
	qnt.text = str(numero)	
	desc = res.description

func _on_focus_entered() -> void:
	get_parent().desc_update(desc)

func _on_pressed() -> void:
	get_parent().focus_on_use()
	print(item_name)
	get_parent().selected_item = item_name
	get_parent().print_item()
