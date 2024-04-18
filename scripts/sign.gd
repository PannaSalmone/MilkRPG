extends StaticBody2D

@export var dialogue: String = ""
@export var objname: String = "firmar"
var texto:String = ""

func main_func():
	texto = str(objname+ ": " + dialogue)
