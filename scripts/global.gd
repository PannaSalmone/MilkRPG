extends Node2D

#Global flags and var

#Game var
var is_paused := false
var active_party = [
	"Renzo",
	"Lucia", 
	]

var gold := 500 #Initial amount of money 
var movcounter : float

#Player 1 var
#var name1 := "Renzo"
#var level1 : int = 1
#var exp1 :int = 0
#var hp1 :int = 100

#Position Var (for transition between areas and maps)
var player_xy := Vector2(64 , 64) #coordinates on map
var raycast_direction := Vector2(0 , 32)
var player_map_location := "test_area"

#Chest flags
var chest_flags = [0, 0, 0, 0] #[ID, ID] #0= closed,  1 = opened
#chest_flags ID = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


