extends VBoxContainer

func desc_update(desc):
	%Description.text = desc

func focus_on_use():
	$"../../ButtonPanel/use".grab_focus()
	
