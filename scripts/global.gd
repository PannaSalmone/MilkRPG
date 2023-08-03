extends Node2D

#Global flags and var

#Player var
var playerispaused := false
var active_member := 2
var name1 := "Mario"
var gold := 500 #Initial amount of money 

#Position Var (for transition between areas and maps)
var player_xy := Vector2(32 , 32) #coordinates on map
var raycast_direction := Vector2(0 , 32)
var player_map_location := "test_area"

#Chest flags
var chest_flags = [0, 0] #[ID, ID] #{Chest0, Chest1, Chest3}

#inventory
var items = {
		sword = 0 ,
		hammer = 1,
		Apple = 0,
		Banana = 6
}

#@export_flags("Player", "Buddy", "Giulia", "Anna") var active_party = 1 # I:1 II:2 III:4 IV:8, Ex: party with I,III,IV = 1+4+8 = Value of 13


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


