extends Control

onready var order_list := $ItemList 
var troops_available:Dictionary
var towers:Dictionary
var slot_scn:PackedScene = preload("res://ui/planning_unitSlot.tscn")
var slots:Array
var factory_scn = preload("res://factory.gd")
var factory

var bMoving := false
var moving_start:Vector2

func _ready()->void:
	order_list.max_columns = 500
	$Move.connect("button_down",self,"_on_move_down")
	$Move.connect("button_up",self,"_on_move_up")
	#$Move.keep_pressed_outside = true #does nothing
	$Attack.connect("pressed",self,"_on_attack_pressed")
	$MoveLeft.connect("pressed",self,"_on_moveleft_pressed")
	$MoveLeft.connect("pressed",self,"_on_moveright_pressed")

func _on_move_down()->void:
	assert(!bMoving)
	bMoving = true
	moving_start = Vector2(margin_left,margin_top)-get_viewport().get_mouse_position()
	
func _on_move_up()->void:
	assert(bMoving)
	bMoving = false
	
func _on_attack_pressed()->void:
	pass
func _on_moveleft_pressed()->void:
	pass
func _on_moveright_pressed()->void:
	pass

func _process(delta:float)->void:
	if(bMoving):
		margin_left = moving_start.x + get_viewport().get_mouse_position().x
		margin_top = moving_start.y + get_viewport().get_mouse_position().y
		margin_right = margin_left
		margin_bottom = margin_top
		
func setup(avail_troops:Dictionary,towers:Dictionary)->void:
	order_list.select_mode = order_list.SELECT_MULTI
	
	troops_available = avail_troops
	factory = factory_scn.new()
	#create and setup troop planning_unitSlot scenes
	for t in troops_available.keys():
		var inst = slot_scn.instance()
		add_child(inst)#container_slots.add_child(inst)
		inst.setup(t,troops_available.get(t))
#		slots.resize(slots.size()+1
		if(slots.size()-1 < t):
			slots.resize(t+1)
		slots[t] = inst
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_bottom = 130+200
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_right = ((t+1))*(64-8)+8 # TODO add placeholders in between
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_left = ((t+1)-1)*(64+8)
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_top = 200
		inst.rect_size = Vector2(64,130)

func order_remove(id:int)->void:
	if(order_list.is_anything_selected()): #look in selection first
		for s in order_list.get_selected_items():
			if(order_list.get_item_metadata(s) == id):
				order_list.remove_item(s)
				order_update()
				return
	for i in order_list.get_item_count():
		if(order_list.get_item_metadata(i) == id):
				order_list.remove_item(i)
				order_update()
				return

func order_update()->void:
	for i in order_list.get_item_count():
		order_list.set_item_text(i,"%s:%s"%[i,order_list.get_item_text(i).split(":")[1]])

func order_add(id:int)->void:
	order_list.add_item("%s:%s"%[order_list.get_item_count(),factory.troop_name[id]],factory.troop_tex[id])
	order_list.set_item_metadata(order_list.get_item_count()-1,id)