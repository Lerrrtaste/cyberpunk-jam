extends Object

var tower_name:Array
var tower_text_body:Array
var tower_text_barrel:Array
var tower_attack:Array
var tower_ability:Array

var troop_name:Array
var troop_text:Array
var troop_attack:Array
var troop_ability:Array

func _init()->void:
	build_tower()
	build_troop()

func build_troop()->void:
	troop_name[0] = "Base"
	troop_name[1] = "N/A"
	troop_name[2] = "N/A"
	troop_name[3] = "N/A"
	troop_name[4] = "N/A"
	troop_name[5] = "N/A"
	troop_name[6] = "N/A"
	troop_name[7] = "N/A"
	troop_name[8] = "N/A"
	tower_name[9] = "Tank"
	tower_name[10] = "Hacker"
	troop_name[11] = "N/A"
	
	troop_text[0] = "res://Assets/Placeholder/troop.png"
	troop_text[1] = "res://Assets/Placeholder/troop.png"
	troop_text[2] = "res://Assets/Placeholder/troop.png"
	troop_text[3] = "res://Assets/Placeholder/troop.png"
	troop_text[4] = "res://Assets/Placeholder/troop.png"
	troop_text[5] = "res://Assets/Placeholder/troop.png"
	troop_text[6] = "res://Assets/Placeholder/troop.png"
	troop_text[7] = "res://Assets/Placeholder/troop.png"
	troop_text[8] = "res://Assets/Placeholder/troop.png"
	troop_text[9] = "res://Assets/Placeholder/troop.png"
	troop_text[10] = "res://Assets/Placeholder/troop.png"
	troop_text[11] = "res://Assets/Placeholder/troop.png"
	
	troop_attack[0] = "res://troop/attacks/troop_attack_base.tscn"
	troop_attack[1] = null
	troop_attack[2] = null
	troop_attack[3] = null
	troop_attack[4] = null
	troop_attack[5] = null
	troop_attack[6] = null
	troop_attack[7] = null
	troop_attack[8] = null
	troop_attack[9] = null
	troop_attack[10] = null
	troop_attack[11] = null
	
	troop_ability[0] = "res://troop/abilities/troop_ability_base.tscn"
	troop_ability[1] = null
	troop_ability[2] = null
	troop_ability[3] = null
	troop_ability[4] = null
	troop_ability[5] = null
	troop_ability[6] = null
	troop_ability[7] = null
	troop_ability[8] = null
	troop_ability[9] = null
	troop_ability[10] = null
	troop_ability[11] = null

func build_tower()->void:
	tower_name[0] = "Base"
	tower_name[1] = "N/A"
	tower_name[2] = "Gatling Gun"
	tower_name[3] = "Flak"
	tower_name[4] = "Roadblock"
	tower_name[5] = "N/A"
	tower_name[6] = "N/A"
	tower_name[7] = "N/A"
	tower_name[8] = "N/A"
	tower_name[9] = "N/A"
	tower_name[10] = "N/A"
	tower_name[11] = "N/A"
	
	tower_text_body[0] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[1] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[2] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[3] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[4] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[5] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[6] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[7] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[8] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[9] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[10] = "res://Assets/Placeholder/tower_body.png"
	tower_text_body[11] = "res://Assets/Placeholder/tower_body.png"
	
	tower_text_barrel[0] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[1] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[2] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[3] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[4] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[5] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[6] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[7] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[8] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[9] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[10] = "res://Assets/Placeholder/tower_barrel.png"
	tower_text_barrel[11] = "res://Assets/Placeholder/tower_barrel.png"
	
	tower_attack[0] = "res://tower/attacks/tower_attack_base.tscn"
	tower_attack[1] = null
	tower_attack[2] = null
	tower_attack[3] = null
	tower_attack[4] = null
	tower_attack[5] = null
	tower_attack[6] = null
	tower_attack[7] = null
	tower_attack[8] = null
	tower_attack[9] = null
	tower_attack[10] = null
	tower_attack[11] = null
	
	tower_ability[0] = "res://tower/abilities/tower_ability_base.tscn"
	tower_ability[1] = null
	tower_ability[2] = null
	tower_ability[3] = null
	tower_ability[4] = null
	tower_ability[5] = null
	tower_ability[6] = null
	tower_ability[7] = null
	tower_ability[8] = null
	tower_ability[9] = null
	tower_ability[10] = null
	tower_ability[11] = null