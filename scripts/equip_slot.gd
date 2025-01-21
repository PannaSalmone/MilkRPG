extends Button

signal remove_item
signal item_focused(desc : String)
signal item_selected(item_res : Resource)
@onready var texture_rect := $HBoxContainer/icon
@onready var obj_name := $HBoxContainer/name
@onready var qnt := $HBoxContainer/qnt

var no_equip := false
var item_slot : Resource
var desc := ""
#var locked := false

func _ready() -> void:
	pass

func set_equip_data(slot) -> void:
	var item_res = slot.item
	item_slot = slot
	desc = item_res.description
	texture_rect.texture = item_res.icon
	obj_name.text = item_res.name
	qnt.text = str(slot.qnt)

func no_item():
	desc = "Remove item"
	obj_name.text = "Remove item"

func _on_pressed() -> void:
	if no_equip == false:
		emit_signal("item_selected", item_slot.item)
	else:
		emit_signal("remove_item")

func _on_focus_entered() -> void:
	emit_signal("item_focused", desc)
