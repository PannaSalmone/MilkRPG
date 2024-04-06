@tool
extends StaticBody2D
class_name Chest

@export var ID: int = 0 ##ID must be unique
@export_enum("Default", "Blue") var chest_sprite: String #the name of the chest sprite (check the names in the sprite OW folder
@export_enum("Item","Gold") var content: String
@onready var sprite = $ChestSprite
@export var item : ItemData
@export var amount: int = 1 
var is_open = false
var texto := ""
signal add_item_sig

# Called when the node enters the scene tree for the first time.
func _ready():
	var char_tex = load("res://sprites/OW/Chest_"+ chest_sprite +".png") 
	$ChestSprite.texture = (char_tex)
	if Global.chest_flags[ID] == 1:
		is_open = true
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 ))

#called by Player.gd
func main_func():
	if is_open == false:
		add_item()
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 )) #change area of the sprite atlas (opened chest)
		Global.chest_flags[ID] = 1
		is_open = true
	else:
		texto = "it's empty"

func add_item():
	if content == "Item":
		var new_items : Dictionary
		new_items[item] = amount
		Utils.add_item(new_items)
		texto = str("You found: " + str(amount) + " " + item.name)
	else:
		Global.gold += amount
		texto = str("You found: " + str(amount) + " Gold")
