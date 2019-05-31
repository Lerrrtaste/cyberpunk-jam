extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.stream = preload("res://Assets/win.ogg")
	$AudioStreamPlayer.play()
	$BtnVote.connect("pressed",self,"_on_vote_pressed")
	$BtnExit.connect("pressed",self,"_on_exit_pressed")
	$BtnMenu.connect("pressed",self,"_on_menu_pressed")
	if(OS.get_name() == "HTML5"):
		$BtnExit.visible = false

func _on_vote_pressed()->void:
	OS.shell_open("https://itch.io/jam/cyberpunk-jam-2019/rate/429490") #TODO change

func _on_exit_pressed()->void:
	get_tree().quit()

func _on_menu_pressed()->void:
	get_tree().change_scene("res://test.tscn")