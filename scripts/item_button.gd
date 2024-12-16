extends Button

signal item_focused(desc : String)
signal item_selected(item_res : Resource)
@onready var qnt := $ItemPanel/qnt
@onready var texture_rect := $ItemPanel/TextureRect
@onready var obj_name := $ItemPanel/name
@onready var info := $ItemPanel/info
@onready var info_s := $ItemPanel/info2
var item_slot : Resource
var desc := ""
var locked := false

func _ready() -> void:
	pass

func set_equip_data(slot) -> void:
	var item_res = slot.item
	item_slot = slot
	texture_rect.texture = item_res.icon
	obj_name.text = item_res.name
	qnt.text = str(slot.qnt)

func no_item() -> void:
	obj_name.text = "Remove item"

func set_slot_data(slot) -> void:
	var item_res = slot.item
	item_slot = slot
	texture_rect.texture = item_res.icon
	obj_name.text = item_res.name
	info_s.text = item_res.type
	#if res.type == "armor":
		#info_s.text = "def: " + str(res.defence)
	qnt.text = str(slot.qnt)
	desc = item_res.description
	if slot.is_locked == true:
		qnt.text = "E"
		locked = true
		obj_name.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))

func _on_focus_entered() -> void:
	emit_signal("item_focused", desc)

func _on_pressed() -> void:
	if locked == false:
		emit_signal("item_selected", item_slot)


	
