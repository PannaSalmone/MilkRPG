extends Node2D
@export var skip_menu := true

func _ready():
	if skip_menu == true:
		loadgame()



func _on_new_game_pressed():
	loadgame()


func _on_continue_pressed():
	pass # Replace with function body.

func loadgame():
	get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")
