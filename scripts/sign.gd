extends StaticBody2D

@export var index: int
var text_box = load("res://scenes/menu/text_box.tscn")
var texto:String = ""

func main_func() -> void:
	var box = text_box.instantiate()
	add_child(box)
	box.type = 1 #chest type
	box.index = index
	box.write_dialog()
