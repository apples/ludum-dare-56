class_name RangeAttackAction
extends ActionLeaf

var range = 50
var bullet_scene = preload("res://objects/units/mage/magic_bullet.tscn")

func tick(actor: Node, blackboard: Blackboard) -> int:
	var target_opponent = blackboard.get_value("target_opponent")
	if not is_instance_valid(target_opponent):
		return FAILURE
		
	if actor.global_position.distance_to(target_opponent.global_position) < range: #&& cooldown.is_stopped():
		var bullet = bullet_scene.instantiate()
		bullet.global_position = actor.global_position
		bullet.velocity = (target_opponent.global_position - actor.global_position).normalized() * 50
		bullet.damage = actor.attack_points
		bullet.team = actor.team
		actor.get_parent().add_child(bullet)
		#return RUNNING
	else:
		return FAILURE
	
	if is_instance_valid(target_opponent):
		return SUCCESS
	else:
		return FAILURE
