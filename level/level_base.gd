extends Node

onready var nav2d = $Navigation2D
onready var troop_start = $TroopStart
onready var troop_end = $TroopEnd
var factory_scn = preload("res://factory.gd")
var factory

var troop_path:PoolVector2Array
var bAttacking := false
var avail_troops:Dictionary = {0 : 100} # TODO get from managing scene

var display_debug := false

func _ready() -> void:
	pass

func start_attack()->void:
	assert(bAttacking == false)
	bAttacking = true
	factory = factory_scn.new()
	troop_path = nav2d.get_simple_path(troop_start.position,troop_end.position,false)
	if(!display_debug):
		$Line2D.visible = false 
	$Line2D.points = troop_path