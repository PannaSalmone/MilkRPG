extends DataItem

@export_group("data")
@export_enum("recover HP","recover MP","cure status","cast magic") var function : String
@export var power : int
@export var battle_sprite : Texture

func main_func()-> void:
	match function:
		"recover HP":
			print("healed for " + str(power) + " HP!")
		_:
			pass
