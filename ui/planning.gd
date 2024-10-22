extends Control

onready var order_list := $ItemList 
var troops_unlocked:Dictionary
var towers:Dictionary
var slot_scn:PackedScene = preload("res://ui/planning_unitSlot.tscn")
var slots:Array
var factory_scn = preload("res://factory.gd")
var factory

var bMoving := false
var moving_start:Vector2

var bDisplayNames := false #TODO disable whan all troops have textures

# 2.0
var cost_total := 0
var money := 25

var amount_selected := 1
const amounts := [1,5,20]
var amount_idx := 1

var units_pending := 0
const units_per_tower := 5
const skip_reward_tower := 10
export(float) var spawn_speed:float = 1.0 # sec between spawn

func _ready()->void:
	order_list.max_columns = 500
	$Move.connect("button_down",self,"_on_move_down")
	$Move.connect("button_up",self,"_on_move_up")
	#$Move.keep_pressed_outside = true #does nothing
	$Attack.connect("pressed",self,"_on_attack_pressed")
	$MoveLeft.connect("pressed",self,"_on_moveleft_pressed")
	$MoveRight.connect("pressed",self,"_on_moveright_pressed")
	$DeleteSelction.connect("pressed",self,"_on_delete_pressed")
	$Amount.connect("pressed",self,"_on_amount_pressed")
	
	$AttackAudio.stream = preload("res://Assets/sfx/ui_attack.wav")
	$ClickAudio.stream = preload("res://Assets/sfx/ui_click.wav")
	
	get_node("../").get_node("Info/NextTower/Skip").connect("pressed",self,"_on_pressed_skip")
	get_node("../").get_node("Info/NextTower").max_value = units_per_tower

func _on_amount_pressed()->void:
	$ClickAudio.play()
	if(amount_idx >= amounts.size()):
		amount_idx = 0
	amount_selected = amounts[amount_idx]
	$Amount.text = "%sx"%amount_selected
	amount_idx += 1

func _on_slider_change(value:float)->void:
	$SliderDesc.text = "Spawn cooldown\n%ss"%str(value*1)
	print("Happened")
	
func _on_delete_pressed()->void:
	$ClickAudio.play()
	var run := 0
	for i in order_list.get_selected_items():
		slots[order_list.get_item_metadata(i-run)]._on_pressed_dec()
		run += 1

func _on_move_down()->void:
	$ClickAudio.play()
	assert(!bMoving)
	bMoving = true
	moving_start = Vector2(margin_left,margin_top)-get_viewport().get_mouse_position()
	
func _on_move_up()->void:
	$ClickAudio.play()
	assert(bMoving)
	bMoving = false

func _on_pressed_skip()->void:
	$ClickAudio.play()
	money += skip_reward_tower * (units_per_tower - units_pending)
	units_pending = units_per_tower

func _on_attack_pressed()->void:
	if(cost_total > money):
		$Attack.text = "Too expensive!"
		return
	if($ItemList.get_item_count() == 0):
		return
	money -= cost_total
	cost_total = 0
	var order_array:Array
	$AttackAudio.play()
	for i in order_list.get_item_count():
		order_array.append(order_list.get_item_metadata(i))
	get_node("../").start_attack(order_array, spawn_speed) #might wanna pass junction selection for pathfinding
	visible = false
	$ItemList.clear()
	for s in slots:
		if(is_instance_valid(s)):
			s.count_selected = 0
			s.update_avail()
	$Attack.text = "Buy&Attack"
	#queue_free()
	
func _on_moveleft_pressed()->void:
	$ClickAudio.play()
	for i in order_list.get_selected_items():
		if(i>0):
			order_list.move_item(i,i-1)
	order_update()

func _on_moveright_pressed()->void:
	$ClickAudio.play()
	for i in order_list.get_selected_items():
		print(i,i<order_list.get_item_count())
		if(i<order_list.get_item_count()):
			order_list.move_item(i,i+1)
	order_update()

func _process(delta:float)->void:
	$MoveLeft.disabled = ($ItemList.get_selected_items().size() == 0)
	$MoveRight.disabled = $MoveLeft.disabled
	$CostTotal.text = "TOTAL COST:\n%s$"%[cost_total]
	if(cost_total > money):
		$CostTotal.add_color_override("font_color",ColorN("red"))
	else:
		$CostTotal.add_color_override("font_color",ColorN("black"))
	get_node("../").get_node("Info/NextTower").value = units_pending
	get_node("../").get_node("Info/NextTower/Name").text = "%s viruses until\nnew defense"%(units_per_tower-units_pending)
	get_node("../").get_node("Info/NextTower/Skip").text = "Skip for %s$"%((units_per_tower-units_pending) * skip_reward_tower)
	if(units_pending >= units_per_tower):
		get_node("../").spawn_tower()
		units_pending -= units_per_tower
	
	if(bMoving):
		margin_left = moving_start.x + get_viewport().get_mouse_position().x
		margin_top = clamp(moving_start.y + get_viewport().get_mouse_position().y,-200,5200)
		margin_right = margin_left
		margin_bottom = margin_top + 20


func setup(avail_troops:Dictionary,towers:Dictionary)->void:
	order_list.select_mode = order_list.SELECT_MULTI
	
	#troops_unlocked = avail_troops
	factory = factory_scn.new()
	#create and setup troop planning_unitSlot scenes
	for t in avail_troops.keys():
		var spacing
		match(t):
			0:
				spacing = 2
			1:
				spacing = 3
			2:
				spacing = 4
			4:
				spacing = 5
			5:
				spacing = 6
			8:
				spacing = 0
			_:
				spacing = 7
		troops_unlocked[t] = (t == 8) ## all locked except keylogger # REMOVED FOR DBG
		var inst = slot_scn.instance()
		add_child_below_node($ItemList,inst)#container_slots.add_child(inst)
		inst.setup(t,99999999)
#		slots.resize(slots.size()+1
		if(slots.size()-1 < t):
			slots.resize(t+1)
		slots[t] = inst
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_bottom = 230+200
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_right = ((spacing+1))*(64-8)+8 # TODO add placeholders in between
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_left = ((spacing+1)-1)*(64+8)
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_top = 280
		inst.rect_size = Vector2(64,175)

func order_remove(id:int)->void:
	cost_total -= factory.troop_cost[id]
	$ClickAudio.play()
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
		if(!bDisplayNames):
			order_list.set_item_text(i, str(i))
		else:
			order_list.set_item_text(i,("%s:%s"%[i,order_list.get_item_text(i).split(":")[1]]))

func request_unlock(id:int)->void:
	if(money >= factory.troop_unlockcost[id] && !troops_unlocked[id]):
		troops_unlocked[id] = true
		money -= factory.troop_unlockcost[id]
		print(id, " unlocked")
		$ClickAudio.play()

func order_add(id:int)->bool:
	$ClickAudio.play()
	if(!troops_unlocked[id]):
		return false
	if(bDisplayNames):
		order_list.add_item("%s:%s"%[order_list.get_item_count(),factory.troop_name[id]],factory.troop_tex[id])
	else:
		order_list.add_item(str($ItemList.get_item_count()),factory.troop_tex[id])
	cost_total += factory.troop_cost[id]
	order_list.set_item_metadata(order_list.get_item_count()-1,id)
	return true