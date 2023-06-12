extends Resource
class_name Save_Game

var save_game_path: Resource = Save_Data

@export var gold: int = preload("res://data/save_data.tres").save_gold

func write_save_game() -> void:
	print(gold)
	save_gold = Global.gold
	print(gold)
	
	ResourceSaver.save(save_game_path)
