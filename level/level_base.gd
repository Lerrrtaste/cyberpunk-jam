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
var avail_troops:Dictionary = {0 : 99} # TODO get from managing scene

var display_debug := false

func get_nearby_troops(idx:int, idx_range:int)->Array:
	var ret:Array
	for i in range(-idx_range/2,idx_range/2):
		if(troops_alive.size()-1 >= idx+i):
			ret.append(troops_alive[idx+i])
	return ret

func _ready() -> void:
	factory = factory_scn.new()
	spawn_timer.connect("timeout",self,"_on_spawn_timeout")
#	planning = planning_scn.instance()
#	add_child(planning)

func _on_spawn_timeout()->void:
	var inst = factory.new_troop(spawn_order[0])
	add_child(inst)
	#maybe troop setup? HERE
	troops_alive.append(inst)
	inst.order_pos = spawn_count
	inst.boost(spawn_timer.wait_time*boost_count)
	spawn_count += 1
	spawn_order.remove(0)
	if(spawn_order.size() == 0):
		spawn_timer.stop()

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
	assert(bAttacking == false)
	bAttacking = true
	troop_path = nav2d.get_simple_path(troop_start.position,troop_end.position,false)
	if(!display_debug):
		$Line2D.visible = false 
	$Line2D.points = troop_path
	
	spawn_order = order_array
	spawn_timer.start(spawn_rate)