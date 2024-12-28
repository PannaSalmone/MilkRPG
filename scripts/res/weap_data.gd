extends DataItem

@export_group("data")
@export_enum("bow","sword","hammer","rod","spear") var weap_type : String
@export var power : int
@export_enum("none","fire","ice","thunder","wind","light","dark") var element : String
@export var battle_sprite : Texture
