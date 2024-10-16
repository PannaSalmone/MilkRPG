extends Node2D

#Global flags and var

#Game var
var is_paused := false
var active_party = [
	"Renzo",
	"Lucia", 
	]

var game_time := 0 
var gold := 500 #Initial amount of money 
var movcounter : float = 0.0 #used for random encounters


#Position Var (for transition between areas and maps)
var player_xy := Vector2(64 , 64) #coordinates on map
var raycast_direction := Vector2(0 , 32)
var player_map_location := "test_area"

#Chest flags
var chest_flags = [0, 0, 0, 0, 0] #[ID, ID] #0= closed,  1 = opened
#chest_flags ID = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
