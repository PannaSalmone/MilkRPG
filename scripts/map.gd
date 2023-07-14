extends TileMap

@export var MAP_GROUP_ID: int = 0
@export var number_of_chest: int = 2
@export_flags("Chest0", "Chest2") var chest_flags = 0 # I:1 II:2 III:4 IV:8, Ex: party with I,III,IV = 1+4+8 = Value of 13

const FLAG_PATH = "res://mapflags_json.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file := FileAccess.open(FLAG_PATH, FileAccess.READ)
	
	for number in range(number_of_chest):
		print(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
