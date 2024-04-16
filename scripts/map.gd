extends TileMap


@export var MAP_GROUP_ID: int = 0
#@export var number_of_chest: int = 2
#@export_flags("Chest0", "Chest2") var chest_flags = 0 # I:1 II:2 III:4 IV:8, Ex: party with I,III,IV = 1+4+8 = Value of 13
@export var random_encounters := true
@export var encounter_rate := 1 #
var battlecountdown : int = 255
var counter : float
#const FLAG_PATH = "res://mapflags_json.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	if random_encounters == true:
		battlecountdown = randi_range ( 120, 255 )
		print(battlecountdown)
	
	#var file := FileAccess.open(FLAG_PATH, FileAccess.READ)
	#for number in range(number_of_chest):
	#print(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.is_moving == true:
		counter += encounter_rate * delta * ($Player.speed / 10)
		print(counter)
		if battlecountdown < counter:
			Utils.load_battle()
