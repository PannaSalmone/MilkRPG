extends HBoxContainer

signal swap(charname)
var is_active = false
var charname = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_active == true:
		if Input.is_action_just_pressed("A"):
			emit_signal("swap", charname)
			

func set_slot_data(res) -> void:
	$Portrait.texture = res.portrait
	$Name.text = res.name
	charname = res.name
	$HP.text = "HP: " + str(res.HP)

func _on_focus_entered() -> void:
	$">".show()
	is_active = true
	
func _on_focus_exited() -> void:
	$">".hide()
	is_active = false

