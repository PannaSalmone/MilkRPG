extends MarginContainer

signal close_menu

func _ready() -> void:
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("B"):
		emit_signal("close_menu")

func _on_exit_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/title_menu.tscn")
	
func _on_exit_game_focus_entered() -> void:
	%Description.text = "Return to title menu"

func _on_esc_focus_entered() -> void:
	%Description.text = "Back to stats menu"
	
func _on_esc_pressed() -> void:
	emit_signal("close_menu")
