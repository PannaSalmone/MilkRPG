extends Button

signal item_focused(desc : String)
signal item_selected(item_res : Resource)
@onready var qnt := $ItemPanel/qnt
@onready var texture_rect := $ItemPanel/TextureRect
@onready var obj_name := $ItemPanel/name
@onready var info := $ItemPanel/info
@onready var info_s := $ItemPanel/info2
var item_res : Resource
var desc := ""

func _ready() -> void:
	pass

func set_slot_data(res, numero) -> void:
	texture_rect.texture = res.icon
	obj_name.text = res.name
	item_res = res
	info_s.text = res.type
	#if res.type == "armor":
		#info_s.text = "def: " + str(res.defence)
	qnt.text = str(numero)
	desc = res.description

func _on_focus_entered() -> void:
	emit_signal("item_focused", desc)

func _on_pressed() -> void:
	emit_signal("item_selected", item_res)
	
