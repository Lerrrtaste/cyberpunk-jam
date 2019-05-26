extends Node

var tower_scn:PackedScene = preload("res://tower/tower.tscn")
var tower_name:Array
var tower_tex_body:Array
var tower_tex_barrel:Array
var tower_attack:Array
#var tower_ability:Array
var tower_hp:Array

var troop_scn:PackedScene = preload("res://troop/troop.tscn")
var troop_name:Array
var troop_tex:Array
#var troop_attack:Array
var troop_ability:Array
var troop_hp:Array
var troop_cost:Array

func _init() -> void:
	create_towerDB()
	create_troopDB()

#troop: name, tex, ability
func create_troopDB()->void:
	troop_name.resize(12)
	troop_name[0] = "Exploit"
	troop_name[1] = "Packet Sniffer"
	troop_name[2] = "DDos"
	troop_name[3] = "Trojan"
	troop_name[4] = "Brute force"
	troop_name[5] = "Worm"
	troop_name[6] = "Worm Clone"
	troop_name[7] = "Spoof"
	troop_name[8] = "Keylogger"
	tower_name[9] = "N/A"
	tower_name[10] = "N/A"
	troop_name[11] = "N/A"
	
	troop_tex.resize(12)
	troop_tex[0] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[1] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[2] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[3] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[4] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[5] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[6] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[7] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[8] = preload("res://Assets/Placeholder/troop_tex.tres")
	troop_tex[9] = null
	troop_tex[10] = null
	troop_tex[11] = null
	
#	troop_attack.resize(12)
#	troop_attack[0] = preload("res://troop/attacks/troop_attack_base.tscn")
#	troop_attack[1] = null
#	troop_attack[2] = null
#	troop_attack[3] = null
#	troop_attack[4] = null
#	troop_attack[5] = null
#	troop_attack[6] = null
#	troop_attack[7] = null
#	troop_attack[8] = null
#	troop_attack[9] = null
#	troop_attack[10] = null
#	troop_attack[11] = null
	
	troop_ability.resize(12)
	troop_ability[0] = null
	troop_ability[1] = preload("res://troop/abilities/ability0.tscn")
	troop_ability[2] = preload("res://troop/abilities/ability1.tscn")
	troop_ability[3] = null
	troop_ability[4] = null
	troop_ability[5] = preload("res://troop/abilities/ability2.tscn")
	troop_ability[6] = null
	troop_ability[7] = preload("res://troop/abilities/ability3.tscn")
	troop_ability[8] = preload("res://troop/abilities/ability4.tscn")
	troop_ability[9] = null
	troop_ability[10] = null
	troop_ability[11] = null

	troop_hp.resize(12)
	troop_hp[0] = 100
	troop_hp[1] = 25
	troop_hp[2] = 25
	troop_hp[3] = null
	troop_hp[4] = 500
	troop_hp[5] = 75
	troop_hp[6] = 25
	troop_hp[7] = null
	troop_hp[8] = 10
	troop_hp[9] = null
	troop_hp[10] = null
	troop_hp[11] = null
	
	troop_cost.resize(12)
	troop_cost[0] = 5
	troop_cost[1] = 15
	troop_cost[2] = 50
	troop_cost[3] = null
	troop_cost[4] = 110
	troop_cost[5] = 250
	troop_cost[6] = -1 # cant be bought
	troop_cost[7] = null
	troop_cost[8] = 100
	troop_cost[9] = null
	troop_cost[10] = null
	troop_cost[11] = null

#tower: name, tex_body, tex_barrel, attack
func create_towerDB()->void:
	tower_name.resize(12)
	tower_name[0] = "Anti-Malware"
	tower_name[1] = "Firewall"
	tower_name[2] = "N/A"
	tower_name[3] = "Anti-Virus"
	tower_name[4] = "N/A"
	tower_name[5] = "N/A"
	tower_name[6] = "N/A"
	tower_name[7] = "N/A"
	tower_name[8] = "N/A"
	tower_name[9] = "N/A"
	tower_name[10] = "N/A"
	tower_name[11] = "N/A"
	
	tower_tex_body.resize(12)
	tower_tex_body[0] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[1] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[2] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[3] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[4] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[5] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[6] = null
	tower_tex_body[7] = null
	tower_tex_body[8] = preload("res://Assets/Placeholder/tower_body_tex.tres")
	tower_tex_body[9] = null
	tower_tex_body[10] = null
	tower_tex_body[11] = null
	
	tower_tex_barrel.resize(12)
	tower_tex_barrel[0] = preload("res://Assets/Placeholder/tower_barrel_tex.tres")
	tower_tex_barrel[1] = null
	tower_tex_barrel[2] = null
	tower_tex_barrel[3] = null
	tower_tex_barrel[4] = null
	tower_tex_barrel[5] = null
	tower_tex_barrel[6] = null
	tower_tex_barrel[7] = null
	tower_tex_barrel[8] = null
	tower_tex_barrel[9] = null
	tower_tex_barrel[10] = null
	tower_tex_barrel[11] = null
	
	tower_attack.resize(12)
	tower_attack[0] = preload("res://tower/attacks/attack0.tscn")
	tower_attack[1] = preload("res://tower/attacks/attack1.tscn")
	tower_attack[2] = null
	tower_attack[3] = preload("res://tower/attacks/attack3.tscn")
	tower_attack[4] = preload("res://tower/attacks/attack4.tscn")
	tower_attack[5] = null
	tower_attack[6] = null
	tower_attack[7] = null
	tower_attack[8] = null
	tower_attack[9] = null
	tower_attack[10] = null
	tower_attack[11] = null

func new_tower(id:int)->Node:
	if(id > tower_name.size()-1):
		print("Trying to create tower with id bigger than the name db array (%s, size: %s)"%[str(id),str(tower_name.size())])
		return null
	var inst = tower_scn.instance()
	inst.name = str(tower_name[id])
	if(is_instance_valid(tower_attack[id])):
		var inst_attack = tower_attack[id].instance()
		inst.add_child(inst_attack)
		inst.attack = inst.get_node("Attack")
#	if(is_instance_valid(tower_ability[id])):
#		var inst_ability = tower_ability[id].instance()
#		inst.add_child(inst_ability)
#		inst.ability = inst.get_node("Ability")
	inst.set_noderef()
	# TODO set collision shape based on body tex  size
	if(is_instance_valid(tower_tex_body[id])):
		inst.body.texture = tower_tex_body[id]
	if(is_instance_valid(tower_tex_barrel[id])):
		inst.barrel.texture = tower_tex_barrel[id]
	return inst

func new_troop(id:int)->Node:
	if(id > troop_name.size()-1):
		print("Trying to create troop with id bigger than the name db array (%s, size: %s)"%[str(id),str(troop_name.size())])
		return null
	var inst = troop_scn.instance()
	inst.name = troop_name[id]
	inst.hp_max = troop_hp[id]
#	if(is_instance_valid(troop_attack[id])):
#		var inst_attack = troop_attack[id].instance()
#		inst.add_child(inst_attack)
#		inst.attack = inst.get_node("Attack")
	if(is_instance_valid(troop_ability[id])):
		var inst_ability = troop_ability[id].instance()
		inst.add_child(inst_ability)
		inst.ability = inst.get_node("Ability")
	inst.set_noderef()
	inst.bHighPrio = (id == 4) # id 4 gets target high prio
	if(is_instance_valid(troop_tex[id])):
		inst.sprite.texture = troop_tex[id]
	return inst