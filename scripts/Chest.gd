@tool
extends StaticBody2D
class_name Chest

@export_enum("Default", "Blue") var chest_sprite: String #the name of the chest sprite (check the names in the sprite OW folder
@export_enum("Item","Gold") var content: String
@onready var sprite = $ChestSprite
@export var item = "sword" #totally proof of concept 
@export var amount: int = 1 
var is_closed = true
var texto := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var char_tex = load("res://sprites/OW/Chest_"+ chest_sprite +".png") 
	$ChestSprite.texture = (char_tex)
	
#called by Player.gd
func main_func():
	if is_closed == true:
		add_item()
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 )) #change area of the sprite atlas (opened chest)
		is_closed = false
	else:
		texto = "it's empty"


func add_item():
	if content == "Item":
		texto = str("You found: " + item)

	else:
		Global.gold += amount
		texto = str("You found: " + str(amount) + " Gold")
