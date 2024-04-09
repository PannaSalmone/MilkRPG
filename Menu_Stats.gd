extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var char1data := load("res://data/chars/1.tres")
	get_node("HBoxContainer/PlayerData/1/Name").text = Global.name1
	get_node("HBoxContainer/PlayerData/1/Portrait").texture = char1data.portrait
	get_node("HBoxContainer/PlayerData/1/HP").text = "HP" + str(Global.hp1) + "/" + str(char1data.HP)
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/ButtonPanel/Gold/gold.text = str(Global.gold)
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#Button funcs
func _on_save_pressed() -> void:
	Utils.save_game()

func _on_items_pressed() -> void:
	get_parent().get_parent().item_panel()

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
