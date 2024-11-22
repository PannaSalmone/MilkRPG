extends DataItem

@export_group("data")
@export_enum("consumable", "only battle" ) var category : int
@export_enum("recover HP","recover MP","cure status","cast magic", "increase HP") var function : int
@export var power : int
#@export var battle_sprite : Texture
