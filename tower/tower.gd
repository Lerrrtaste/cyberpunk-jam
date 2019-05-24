extends Node2D

var area2d
var collision_shape
var body
var barrel
var attack = null
#var ability = null

var target = null

func set_noderef()->void:
	area2d = $Area2D
	collision_shape = $Area2D/CollisionShape2D
	body = $Body
	barrel = $Barrel

func _process(delta: float) -> void:
	if(is_instance_valid(attack)):
		attack.step(delta)
#	if(is_instance_valid(ability)):
#		ability.step(delta)
	var target_type = typeof(target)
	if(target_type != TYPE_NIL):
		barrel.rotation = global_position.angle_to(target.global_position)
		#print("Setting barrel rotation: ",global_position.angle_to(target.position)