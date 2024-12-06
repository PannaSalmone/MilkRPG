extends Resource
class_name InitCharData

@export var init_name : String #WIP function to change name
@export var init_level : int

@export_category("stats")
@export_group("stats")
@export var HP: int
@export var MP: int
@export var STRENGHT: int
@export var SPEED: int
@export var VIGOR: int
@export var INTELLECT: int
@export var SPIRIT: int

@export_category("Starting_equipment")
@export var head : DataItem 
@export var body : DataItem 
@export var legs : DataItem 
@export var arms : DataItem
@export var hand_dx : DataItem 
@export var hand_sx : DataItem 
@export var acc1 : DataItem 
@export var acc2 : DataItem 
