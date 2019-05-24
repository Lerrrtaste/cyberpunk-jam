extends Node

onready var nav2d = $Navigation2D
var factory_scn = preload("res://factory.gd")
var factory
func _ready() -> void:
	factory = factory_scn.new()