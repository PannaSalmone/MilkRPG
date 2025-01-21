extends Node

var active_party := []
var selected_char : Resource

@onready var renzo := load("res://data/chars/Renzo.tres")
@onready var lucia := load("res://data/chars/Lucia.tres")

func add_char_to_party(charname) -> void:
	match charname:
		"Renzo":
			active_party.append(renzo)
		"Lucia":
			active_party.append(lucia)

func init_level(charname) -> void:
	var res_init_eq = load ("res://data/initial_data/"+ charname +"_init.tres")
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
			selected_char = c
			var res_init_eq = load ("res://data/initial_data/"+ charname +"_init.tres")
			c.head = res_init_eq.head
			update_modifier("head", gear_stat(c.head))
			c.body = res_init_eq.body
			update_modifier("body", gear_stat(c.body))
			c.arms = res_init_eq.arms
			update_modifier("arms", gear_stat(c.arms))
			c.legs = res_init_eq.legs
			update_modifier("legs", gear_stat(c.legs))
			c.hand_dx = res_init_eq.hand_dx
			update_modifier("hand_dx", gear_stat(c.hand_dx))
			c.hand_sx = res_init_eq.hand_sx
			update_modifier("hand_sx", gear_stat(c.hand_sx))
			c.acc1 = res_init_eq.acc1
			update_modifier("acc1", gear_stat(c.acc1))
			c.acc2 = res_init_eq.acc2
			update_modifier("acc2", gear_stat(c.acc2))
			update_stats(c)
	

func init_char(charname) -> void:
	init_equipment(charname)
	init_level(charname)
	init_stats(charname)

func update_modifier(type: String, stats:Array) -> void:
	match type:
		"head":
			selected_char.atk_modifier[0] = stats[0]
			selected_char.acc_modifier[0] = stats[1]
			selected_char.def_modifier[0] = stats[2]
			selected_char.eva_modifier[0] = stats[3]
			selected_char.mdf_modifier[0] = stats[4]
			selected_char.mev_modifier[0] = stats[5]
			selected_char.mpw_modifier[0] = stats[6]
			selected_char.spe_modifier[0] = stats[7]
		"body":
			selected_char.atk_modifier[1] = stats[0]
			selected_char.acc_modifier[1] = stats[1]
			selected_char.def_modifier[1] = stats[2]
			selected_char.eva_modifier[1] = stats[3]
			selected_char.mdf_modifier[1] = stats[4]
			selected_char.mev_modifier[1] = stats[5]
			selected_char.mpw_modifier[1] = stats[6]
			selected_char.spe_modifier[1] = stats[7]
		"arms":
			selected_char.atk_modifier[2] = stats[0]
			selected_char.acc_modifier[2] = stats[1]
			selected_char.def_modifier[2] = stats[2]
			selected_char.eva_modifier[2] = stats[3]
			selected_char.mdf_modifier[2] = stats[4]
			selected_char.mev_modifier[2] = stats[5]
			selected_char.mpw_modifier[2] = stats[6]
			selected_char.spe_modifier[2] = stats[7]
		"legs":
			selected_char.atk_modifier[3] = stats[0]
			selected_char.acc_modifier[3] = stats[1]
			selected_char.def_modifier[3] = stats[2]
			selected_char.eva_modifier[3] = stats[3]
			selected_char.mdf_modifier[3] = stats[4]
			selected_char.mev_modifier[3] = stats[5]
			selected_char.mpw_modifier[3] = stats[6]
			selected_char.spe_modifier[3] = stats[7]
		"hand_dx":
			selected_char.atk_modifier[4] = stats[0]
			selected_char.acc_modifier[4] = stats[1]
			selected_char.def_modifier[4] = stats[2]
			selected_char.eva_modifier[4] = stats[3]
			selected_char.mdf_modifier[4] = stats[4]
			selected_char.mev_modifier[4] = stats[5]
			selected_char.mpw_modifier[4] = stats[6]
			selected_char.spe_modifier[4] = stats[7]
		"hand_sx":
			selected_char.atk_modifier[5] = stats[0]
			selected_char.acc_modifier[5] = stats[1]
			selected_char.def_modifier[5] = stats[2]
			selected_char.eva_modifier[5] = stats[3]
			selected_char.mdf_modifier[5] = stats[4]
			selected_char.mev_modifier[5] = stats[5]
			selected_char.mpw_modifier[5] = stats[6]
			selected_char.spe_modifier[5] = stats[7]
		"acc1":
			selected_char.atk_modifier[6] = stats[0]
			selected_char.acc_modifier[6] = stats[1]
			selected_char.def_modifier[6] = stats[2]
			selected_char.eva_modifier[6] = stats[3]
			selected_char.mdf_modifier[6] = stats[4]
			selected_char.mev_modifier[6] = stats[5]
			selected_char.mpw_modifier[6] = stats[6]
			selected_char.spe_modifier[6] = stats[7]
		"acc2":
			selected_char.atk_modifier[7] = stats[0]
			selected_char.acc_modifier[7] = stats[1]
			selected_char.def_modifier[7] = stats[2]
			selected_char.eva_modifier[7] = stats[3]
			selected_char.mdf_modifier[7] = stats[4]
			selected_char.mev_modifier[7] = stats[5]
			selected_char.mpw_modifier[7] = stats[6]
			selected_char.spe_modifier[7] = stats[7]
	
func update_stats(char) -> void:
	#atk formula
	var modifier := 0
	for val in char.atk_modifier:
		modifier += val
	char.ATK = modifier + (char.STRENGHT/4)
	#accuracy formula
	modifier = 0
	for val in char.acc_modifier:
		modifier += val
	char.ACC = modifier + (char.INTELLECT/4)
	#def formula
	modifier = 0
	for val in char.def_modifier:
		modifier += val
	char.DEF = modifier + (char.INTELLECT/4)
	#evasion formula
	modifier = 0
	for val in char.eva_modifier:
		modifier += val
	char.EVA = modifier + (char.AGILITY/4)
	#magic def formula
	modifier = 0
	for val in char.mdf_modifier:
		modifier += val
	char.MDF = modifier + ((char.SPIRIT + char.INTELLECT) /4)
	#magic power formula
	modifier = 0
	for val in char.mpw_modifier:
		modifier += val
	char.MPW = modifier + ((char.SPIRIT + char.INTELLECT) /4)
	#speed formula
	modifier = 0
	for val in char.spe_modifier:
		modifier += val
	char.SPE = modifier + (char.AGILITY/4)
	
func gear_stat(gear):
	var item_stats = [0, 0, 0, 0, 0, 0, 0, 0]
	if gear != null:
		item_stats = [
		gear.atk,
		gear.acc,
		gear.def,
		gear.eva,
		gear.mdef,
		gear.meva,
		gear.mpow,
		gear.spe]
	return(item_stats)

func remove_equipment(type:String) -> void:
	#remove selected equipped item
	match type:
		"head":
			selected_char.head = null
		"body":
			selected_char.body = null
		"arms":
			selected_char.arms = null
		"legs":
			selected_char.legs = null
		"hand_dx":
			selected_char.hand_dx = null
		"hand_sx":
			selected_char.hand_sx = null
		"acc1":
			selected_char.acc1 = null
		"acc2":
			selected_char.acc2 = null
	update_modifier(type,gear_stat(null))
	update_stats(selected_char)


func add_equipment(type:String, item:Resource) -> void:
	match type:
			"head":
				selected_char.head = item
			"body":
				selected_char.body = item
			"arms":
				selected_char.arms = item
			"legs":
				selected_char.legs = item
			"hand_dx":
				selected_char.hand_dx = item
			"hand_sx":
				selected_char.hand_sx = item
			"acc1":
				selected_char.acc1 = item
			"acc2":
				selected_char.acc2 = item
	update_modifier(type,gear_stat(item))
	update_stats(selected_char)

func calc_stats() -> void:
	for c in active_party:
			update_modifier("head", gear_stat(c.head))
			update_modifier("body", gear_stat(c.body))
			update_modifier("arms", gear_stat(c.arms))
			update_modifier("legs", gear_stat(c.legs))
			update_modifier("hand_dx", gear_stat(c.hand_dx))
			update_modifier("hand_sx", gear_stat(c.hand_sx))
			update_modifier("acc1", gear_stat(c.acc1))
			update_modifier("acc2", gear_stat(c.acc2))
			update_stats(c)

func init_stats(charname) -> void:
	for c in active_party:
		if c.name == charname:
			c.cur_HP = c.HP
			c.cur_MP = c.MP
