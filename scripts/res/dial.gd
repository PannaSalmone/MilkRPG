extends Resource

@export var obj_name : String
@export var portrait : Texture
@export_multiline var dialogue : Array[String]

#Dialogue guide
#>>This is a line of text,    print this line of text
#n/ New_name   change the name in the textbox with "New_name"
#p/whitemage   change the picture in the textbox with the one with the name "whitemage.png" in the portrait folder
#p/no  hide picture in the textbox
#j   Jump to number int next to "j/" ex. j/10 jump to line 10
#f/int,int  Change global flags, The first number, represents the global_flag number. The second number represents the new value of this flag.
#c/ "c/id:int,value:int" check global flag, if id = value jump to next line, else it skips the next line
#o/2 options WIP
#g/ Give object WIP
#s/ Play sound WIP
#e/ end dialogue
