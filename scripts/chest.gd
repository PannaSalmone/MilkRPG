#@tool
extends MapObject

@export var ID: int = 0 ##ID must be unique
@export_enum("Default", "Blue") var chest_sprite: String #the name of the chest sprite (check the names in the sprite OW folder
@export_enum("Item","Gold") var content: String
@onready var sprite = $ChestSprite
@export var item : DataItem
@export var amount: int = 1 
var is_open = false
var texto := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var char_tex = load("res://sprites/OW/Chest_"+ chest_sprite +".png") 
	$ChestSprite.texture = (char_tex)
	if Global.chest_flags[ID] == 1:
		is_open = true
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 ))

#called by Player.gd
func main_func() -> void:
	var text_box = load("res://scenes/menu/text_box.tscn")
	var box = text_box.instantiate()
	add_child(box)
	if is_open == false:
		match content:
			"Item":
				Utils.add_item(item,amount)
				texto = str("You found: " + str(amount) + " " + item.name)
				box.chest(texto)
			"Gold": #Sign
				Global.gold += amount
				texto = str("You found: " + str(amount) + " Gold")
				box.chest(texto)
		$ChestSprite.region_rect = Rect2i(Vector2 (32, 0,), Vector2 (32, 32 )) #change area of the sprite atlas (opened chest)
		Global.chest_flags[ID] = 1
		is_open = true
	else:
		texto = "it's empty"
		box.chest(texto)
