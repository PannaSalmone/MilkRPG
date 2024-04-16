extends Control

var battler = load("res://battler.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#spawn battler and enemies children
	#add Battlers to battlefield
	var initial_battler_pos = Vector2i(400,40)
	for chara in Global.active_party:
		var char_slot = battler.instantiate()
		if chara:
			$Container/VBoxContainer/BattleField.add_child(char_slot)
			char_slot.take_data(load("res://data/chars/"+ chara+".tres"))
			var distance = Vector2i (15, 50)
			char_slot.position = initial_battler_pos
			initial_battler_pos += distance

	var enemie = load("res://enemie.tscn")
	var en = enemie.instantiate()
	$Container/VBoxContainer/BattleField.add_child(en)
	en.position = Vector2i(100, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_flee_pressed() -> void:
	get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")
