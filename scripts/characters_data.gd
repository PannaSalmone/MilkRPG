extends Resource
class_name Player_Stats

@export var Portrait = Resource
@export var HP: int = 100
@export var MP: int = 50

@export var Strenght: int = 50
@export var Agility: int = 50
@export var Mind: int = 50

enum Hand { Right, Left , Ambi = -1 }
@export var Hand_type: Hand

@export_flags("Sword", "Long_Sword", "Rod", "Bow") var weapon_type = 0
@export_flags("Shield", "Heavy", "light", "Dress") var armors_type = 0
