extends Panel

onready var label_available = $Avail
var factory_scn = preload("res://factory.gd")
var count_max:int 
var count_selected:int = 0

func _ready() -> void:
	$Inc.connect("pressed",self,"_on_pressed_inc")
	$Dec.connect("pressed",self,"_on_pressed_dec")
	

func setup(id:int,count:int):
	var factory = factory_scn.new()
	if(factory.troop_name.size()-1 < id):
		print(self, " Trying to get unit name with too high id!!!")
	$Name.text = factory.troop_name[id]
	$TextureRect.texture = factory.troop_tex[id]
	count_max = count

func _on_pressed_inc()->void:
	if(count_selected<count_max):
		count_selected+=1
		update_avail()

func _on_pressed_dec()->void:
	if(count_selected>0):
		count_selected-=1
		update_avail()
	
func update_avail()->void:
	label_available.text = "%s of %s"%[count_selected,count_max]