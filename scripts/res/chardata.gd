extends Resource
class_name chardata

@export var name: String
@export var surname: String
@export var portrait :Texture
@export var title_class : String
@export var initial_level : int
@export var level : int

@export_group("status")
@export_flags("Poison", "Stone", "Sleep", "Frog") var status = 0

@export_group("stats")
@export var HP: int
@export var MP: int
@export var STRENGHT: int
@export var SPEED: int
@export var VIGOR: int
@export var INTELLECT: int
@export var SPIRIT: int

@export_group("equip_data")
@export_flags("Swords", "Bows", "Hammers", "Rods") var weapons = 0
@export_flags("Heavy", "Lights", "Robes", "Shields") var armors = 0

var equipment = [DataItem,DataItem,DataItem,DataItem,DataItem,DataItem,DataItem,DataItem]


@export_group("Sprites")
@export var battle_sprite :Texture
@export var ow_sprite :Texture
