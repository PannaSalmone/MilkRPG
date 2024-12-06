extends Node

var active_party := []

@onready var renzo := load("res://data/chars/Renzo.tres")
@onready var lucia := load("res://data/chars/Lucia.tres")

func add_char_to_party(charname) -> void:
	match charname:
		"Renzo":
			active_party.append(renzo)
		"Lucia":
			active_party.append(lucia)

func init_level(charname) -> void:
	var res_init_eq = load ("res://data/chars/initial_data/"+ charname +"_init.tres")
	match charname:
		"Renzo":
			renzo.level = res_init_eq.init_level
		"Lucia":
			lucia.level = res_init_eq.init_level
	
func swap_members(char1, char2) -> void:
	var temp = active_party[char1]
	active_party[char1] = active_party[char2]
	active_party[char2] = temp
	
func init_equipment(charname) -> void:
	for c in active_party:
		if c.name == charname:
			var res_init_eq = load ("res://data/chars/initial_data/"+ charname +"_init.tres")
			c.equipment[0] = res_init_eq.head
			c.equipment[4] = res_init_eq.hand_dx
			c.equipment[1] = res_init_eq.body
			c.equipment[5] = res_init_eq.hand_sx
			c.equipment[2] = res_init_eq.legs
			c.equipment[6] = res_init_eq.acc1
			c.equipment[3] = res_init_eq.arms
			c.equipment[7] = res_init_eq.acc2

func init_char(charname) -> void:
	init_equipment(charname)
	init_level(charname)
