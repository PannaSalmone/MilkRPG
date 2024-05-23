extends Control

var sped_dict := {}
var turn_order := []
var current_turn := Node
var state := 0 #0 wait 1 anim

# Called when the node enters the scene tree for the first time.
func _ready():
#spawn battler and enemies children
	#add Battlers to battlefield
	var battler = load("res://scenes/battler.tscn")
	var n = 1
	var battlefield = $Container/VBoxContainer/BattleField
	var initial_battler_pos = Vector2i(450,60)
	for chara in Global.active_party:
		var char_slot = battler.instantiate()
		if chara:
			$Container/VBoxContainer/BattleField.add_child(char_slot)
			char_slot.take_data(load("res://data/chars/"+ chara+".tres"))
			var distance = Vector2i (15, 50)
			char_slot.position = initial_battler_pos
			char_slot.change_state.connect(change_state)
			initial_battler_pos += distance
			var box = get_node("Container/VBoxContainer/CommandPanel/HBoxContainer/StatPanel/StatPanel/Player"+str(n)+"/Name")
			box.text = chara
			n += 1
	
	#add enemies to battlefield from formation resources
	var formation = load("res://data/formations/Enemie_Formation.tres")
	for key in formation.formation_data:
		var enemie = load("res://scenes/enemy.tscn")
		var en = enemie.instantiate()
		$Container/VBoxContainer/BattleField.add_child(en)
		en.take_data(key)
		en.position = formation.formation_data.get(key)
	
	#collect data and stats
	#create an array with the speed stats sorted
	var speedarray := []
	for child in battlefield.get_children():
			sped_dict[child] = child.speed
			speedarray.append(child.speed)
			speedarray.sort()
			speedarray.reverse()
	
	#create turn order array
	for value in speedarray:
		turn_order.append(sped_dict.find_key(value))
	print(turn_order)
	turn_order[0].is_selected()
	make_turn()
	
func make_turn() -> void:
	var list = get_node("Container/VBoxContainer/CommandPanel/HBoxContainer/VBoxContainer")
	var i = 0
	for child in list.get_children():
		if child.name != "title":
			child.text = turn_order[i].NAME
			i += 1
	current_turn = turn_order[0]
	print("current turn: ", current_turn)
	#current_turn.is_selected()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if state == 0:
		#var node = turn_order[0]
		#node.is_selected()
	pass	

func _on_flee_pressed() -> void:
	get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")

func next_turn() -> void:
	turn_order[0].is_selected()
	turn_order.append(turn_order[0])
	turn_order.pop_at(0)
	turn_order[0].is_selected()
	make_turn()
	pass

func _on_attack_pressed() -> void:
	next_turn()

func change_state(n) -> void:
	state = n
	print("signal")
