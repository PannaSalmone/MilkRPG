extends Node2D

#Global flags and var

#Game var
var active_party = [
	"Renzo",
	"Lucia", 
	]

var active_member := 1
var gold := 500 #Initial amount of money 
var Movcounter : float

#Player 1 var
var name1 := "Renzo"
var level1 : int = 1
var exp1 :int = 0
var hp1 :int = 100

#Position Var (for transition between areas and maps)
var player_xy := Vector2(32 , 32) #coordinates on map
var raycast_direction := Vector2(0 , 32)
var player_map_location := "test_area"

#Chest flags
var chest_flags = [0, 0, 0] #[ID, ID] #0= closed,  1 = opened
#chest_flags ID = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


#@export_flags("Player", "Buddy", "Giulia", "Anna") var active_party = 1 # I:1 II:2 III:4 IV:8, Ex: party with I,III,IV = 1+4+8 = Value of 13


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


