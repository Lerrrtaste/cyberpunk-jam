extends Node2D

var area2d
var collision_shape
var sprite
#var attack = null
var ability = null
var tower_prio:Dictionary

export(int) var speed:int = 500

var hp_max:int = -1
var hp:int
var path = null
var target = null

func set_noderef()->void:
	area2d = $Area2D
	collision_shape = $Area2D/CollisionShape2D
	sprite = $Sprite

func _process(delta: float) -> void:
#	if(is_instance_valid(attack)):
#		attack.step(delta)
	if(is_instance_valid(ability)):
		ability.step(delta)
	var target_type = typeof(target)
	if(target_type != TYPE_NIL):
		Sprite.rotation = global_position.angle_to(target.global_position)
	walk(delta)

func walk(delta:float)->void:
	if(typeof(path) == TYPE_NIL):
		path = get_tree().get_root().troop_path
		print(self," updated path")
	move_along_path(delta*speed)

func move_along_path(distance:float)->void:
	if(typeof(path) == TYPE_NIL):
		print("no path set!")
		return
	var start_pos:=position
	for i in range(path.size()):
		var dist_to_next:= start_pos.distance_to(path[0])
		if(distance <= dist_to_next && distance >= 0.0): #can move less than next point, therefore move just towards
			position = start_pos.linear_interpolate(path[0], distance/dist_to_next)
			break
		distance -= dist_to_next
	start_pos = path[0]
	path.remove(0)