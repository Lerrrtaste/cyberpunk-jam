extends Node2D

var area2d
var collision_shape
var body
var barrel

func set_noderef()->void:
	area2d = $Area2D
	collision_shape = $Area2D/CollisionShape2D
	body = $Body
	barrel = $Barrel