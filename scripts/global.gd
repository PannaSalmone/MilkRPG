extends Node2D

#######              Global flags and var

#Game var
var is_paused := false
#Position Var (for transition between areas and maps)
var player_xy := Vector2(64 , 64) #coordinates on map
var raycast_direction := Vector2(0 , 32)
var player_map_location := "test_area"

var game_time := 0 
var gold := 500 #Initial amount of money 
var movcounter : float = 0.0 #used for random encounters

#########                char info
var renzo_cur_hp : int
var renzo_cur_mp : int
var renzo_lv : int
var renzo_status : int #0 normal 1 poisoned 2 paralized

var lucia_cur_hp : int
var lucia_cur_mp : int
var lucia_lv : int
var lucia_status : int #0 normal 1 poisoned 2 paralized


#######                  event flags
#Chest flags
var chest_flags = [0, 0, 0, 0, 0] #[ID, ID] #0= closed,  1 = opened
#chest_flags ID = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
var game_flags = [0, 0]
#game and story flag
