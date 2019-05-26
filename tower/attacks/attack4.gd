extends Area2D

export(float) var cooldown := 5.0
export(float) var time_blocking := 3.0
#var bBlocking := false

func step(delta:float)->void:
	pass

func _ready() -> void:
	$Timer.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	$CollisionShape2D.disabled = false
	yield(get_tree().create_timer(time_blocking), "timeout")
	$CollisionShape2D.disabled = true
	$Timer.start(cooldown)