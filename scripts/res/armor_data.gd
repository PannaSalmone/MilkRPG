extends DataItem

@export_group("data")

@export_enum("head", "body", "hands", "shield", "Accessory") var armor_type : String
@export_enum("heavy", "light", "cloth") var armor_weight : String
@export var defence : int
@export_enum("none","fire","ice","thunder","wind","light","dark") var element : String
