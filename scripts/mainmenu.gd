extends Node2D
@export var skip_menu := false

func _ready():
	if skip_menu == true:
		loadgame()
	$Panel/VBoxContainer/Continue.grab_focus()



func _on_new_game_pressed():
	loadgame()


func _on_continue_pressed():
	Utils.load_game()
	loadgame()

func loadgame():
	get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
