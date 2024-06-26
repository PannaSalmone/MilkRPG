extends Resource
class_name chardata

@export var name: String
@export var portrait :Texture

@export_group("stats")
@export var HP: int
@export var MP: int
@export var STR: int
@export var SPE: int
@export var INT: int

@export_group("equip_data")
@export_flags("Swords", "Bows", "Hammers", "Rods") var weapons = 0
@export_flags("Heavy", "Lights", "Robes", "Shields") var armors = 0

@export_group("Sprites")
@export var battle_sprite :Texture
@export var ow_sprite :Texture
