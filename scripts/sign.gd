extends StaticBody2D

var text_box = load("res://scenes/menu/text_box.tscn")
@export var texto:String = ""
const obj_type := 1

func main_func() -> void:
	var box = text_box.instantiate()
	add_child(box)
	box.type = 1 #set mode to sign
	box.simple_text = texto
	box.sign()
