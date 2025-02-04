extends Panel

onready var label_available = $Avail
var factory_scn = preload("res://factory.gd")
var count_max:int 
var count_selected:int = 0
var id:int
var factory

func _ready() -> void:
	$Inc.connect("pressed",self,"_on_pressed_inc")
	$Dec.connect("pressed",self,"_on_pressed_dec")
	$Unlock.connect("pressed",self,"_on_pressed_unlock")
	$Info.connect("pressed",self,"_on_pressed_info")

func _on_pressed_info():
	$PopUpInfo.pop()

func setup(_id:int,count:int):
	print("Setup ", self , " with troop ID: ", _id)
	id = _id
	factory = factory_scn.new()
	if(factory.troop_name.size()-1 < id):
		print(self, " Trying to get unit name with too high id!!!")
	$Name.text = str(factory.troop_name[id])
	$TextureRect.texture = factory.troop_tex[id]
	#print(factory.troop_tex[id])
	count_max = count
	#margin_right = 64
	update_avail()

func _process(delta: float) -> void:
	if(get_node("../").troops_unlocked[id]):
		$Unlock.visible = false

func _on_pressed_inc()->void:
	for i in get_node("../").amount_selected:
		if(count_selected<count_max):
			if(get_node("../").order_add(id)):
				count_selected+=1
				update_avail()

func _on_pressed_dec()->void:
	for i in get_node("../").amount_selected:
		if(count_selected>0):
			count_selected-=1
			update_avail()
			get_node("../").order_remove(id)

func _on_pressed_unlock()->void:
	get_node("../").request_unlock(id)
	update_avail()

func update_avail()->void:
	if(get_node("../").troops_unlocked[id]):
		label_available.text = "%sx\n%s$\n=%s$"%[count_selected,factory.troop_cost[id],factory.troop_cost[id]*count_selected]
	else:
		label_available.text = "for\n%s$"%[factory.troop_unlockcost[id]]