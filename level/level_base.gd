extends Node

onready var nav2d = $Navigation2D
onready var troop_start = $TroopStart
onready var troop_end = $TroopEnd
onready var spawn_timer = $SpawnTimer
var factory_scn = preload("res://factory.gd")
var factory
var planning_scn = preload("res://ui/planning.tscn")
var planning

var spawn_order:Array
var spawn_count:int = 0
var boost_count:int = 0

var troops_alive:Array

var troop_path:PoolVector2Array
var bAttacking := false
var avail_troops:Dictionary = {	0 : 99,
								1 : 99,
								2 : 99,
								4 : 99,
								5 : 99,
								8 : 99} # TODO get from managing scene

# 2.0
var money:int = 100
var bSpawning:bool = false

var display_debug := false

func get_nearby_troops(idx:int, idx_range:int)->Array:
	var ret:Array
	for i in range(1,idx_range+1):
		if(troops_alive.size()-1 >= idx+i):
			ret.append(troops_alive[idx+i])
		if(0 <= idx-i):
			ret.append(troops_alive[idx-i])
	return ret

func _ready() -> void:
	factory = factory_scn.new()
	spawn_timer.connect("timeout",self,"_on_spawn_timeout")
	$ButtonShop.connect("pressed",self,"_on_shop_pressed")
#	planning = planning_scn.instance()
#	add_child(planning)
	troop_path = nav2d.get_simple_path(troop_start.position,troop_end.position,false)
	if(!display_debug):
		$Line2D.visible = false 
	$Line2D.points = troop_path

func _on_shop_pressed()->void:
	$Planning.visible = !$Planning.visible
	$ButtonShop.text = "Close" if $Planning.visible else "Plan new attack"

func _on_spawn_timeout()->void:
	while($SpawnCast.is_colliding()):
		return
	var inst = factory.new_troop(spawn_order[0])
	add_child_below_node($PosPath,inst)
	inst.global_position.y = -50
	$Planning.units_pending += 1
	#maybe troop setup? HERE
	troops_alive.append(inst)
	inst.order_pos = spawn_count
	#inst.boost(spawn_timer.wait_time*boost_count)
	spawn_count += 1
	spawn_order.remove(0)
	if(spawn_order.size() == 0):
		spawn_timer.stop()
		#bSpawning = false
		$ButtonShop.visible = true

func register_death(inst:Node2D)->void:
	troops_alive.remove(inst.order_pos)
	spawn_count = 0
	boost_count += 1
	for t in troops_alive:
		t.order_pos = spawn_count
		if(inst.order_pos <= spawn_count):
			t.boost(spawn_timer.wait_time)
			
		spawn_count += 1

func start_attack(order_array:Array, spawn_rate:float )->void:
	#bSpawning = true
	$ButtonShop.visible = false
	#assert(bAttacking == false)
	#bAttacking = true
	
	
	spawn_order = order_array
	spawn_timer.start(spawn_rate)

