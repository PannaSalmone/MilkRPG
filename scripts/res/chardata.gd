extends Resource
class_name chardata

@export var name: String
@export var surname: String
@export var portrait :Texture
@export var title_class : String
@export var level : int
@export var exp : int

@export_group("equip_data")
@export_enum("DX", "SX","Ambi") var primary_hand : String
@export_flags("Swords", "Bows", "Hammers", "Rods") var weapons = 0
@export_flags("Heavy", "Lights", "Robes", "Shields") var armors = 0

@export_group("equipment")
@export var head :DataItem
@export var body :DataItem
@export var arms :DataItem
@export var legs :DataItem
@export var hand_dx :DataItem
@export var hand_sx :DataItem
@export var acc1 :DataItem
@export var acc2 :DataItem

@export_group("status")
@export var cur_HP : int
@export var cur_MP : int
@export_flags("Poison", "Stone", "Sleep", "Frog") var status = 0

@export_group("stats")
@export var HP: int
@export var MP: int
@export var STRENGHT: int
@export var AGILITY: int
@export var VIGOR: int
@export var INTELLECT: int
@export var SPIRIT: int

@export_group("derivated_stats")
@export var ATK: int
@export var ACC: int
@export var DEF: int
@export var EVA: int
@export var MDF: int
@export var MEV: int
@export var MPW: int
@export var SPE: int

var atk_modifier : Array = [0,0,0,0,0,0,0,0]
var acc_modifier : Array = [0,0,0,0,0,0,0,0]
var def_modifier : Array = [0,0,0,0,0,0,0,0]
var eva_modifier : Array = [0,0,0,0,0,0,0,0]
var mdf_modifier : Array = [0,0,0,0,0,0,0,0]
var mev_modifier : Array = [0,0,0,0,0,0,0,0]
var mpw_modifier : Array = [0,0,0,0,0,0,0,0]
var spe_modifier : Array = [0,0,0,0,0,0,0,0]

@export_group("Sprites")
@export var battle_sprite :Texture
@export var ow_sprite :Texture
