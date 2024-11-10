extends GridContainer

var selected_item := "culo"

func desc_update(desc):
	%Description.text = desc

func focus_on_use():
	$"../../ButtonPanel/use".grab_focus()
	
func print_item():
	print(selected_item)
