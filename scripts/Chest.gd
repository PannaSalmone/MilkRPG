@tool
extends StaticBody2D
class_name Chest

@export_enum("Default", "Blue") var chest_sprite: String #the name of the chest sprite (check the names in the sprite OW folder
@onready var sprite = $ChestSprite
@export var item = "sword" #totally proof of concept 
var is_closed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var char_tex = load("res://sprites/OW/Chest_"+ chest_sprite +".png") 
	$ChestSprite.texture = (char_tex)
	
#called by Player.gd
func main_func():
	if is_closed == true:
		print("u found ", item)		
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 )) #change area of the sprite atlas (opened chest)
		is_closed = false
	else:
		print("IT IS EMPTY")


