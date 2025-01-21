extends Button

signal swap(charname)
signal selected_char(char_name : String)
#signal selected_char(charname)
var is_active = false
var charname = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_slot_data(res) -> void:
	$HBoxContainer/Portrait.texture = res.portrait
	$HBoxContainer/Name.text = res.name
	charname = res.name
	$HBoxContainer/HP.text = "HP: " + str(res.cur_HP)+" / "+ str(res.HP)
	$HBoxContainer/LV.text = "LV: " + str(res.level)

func _on_focus_entered() -> void:
	$HBoxContainer/space.show()
	is_active = true
	
func _on_focus_exited() -> void:
	$HBoxContainer/space.hide()
	is_active = false

func _on_pressed() -> void:
	print("culos")
	var parent_check = get_parent()
	if parent_check.is_class("VBoxContainer"):
		var id = get_index()		
		emit_signal("swap", id)
		emit_signal("selected_char",charname)
