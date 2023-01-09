extends Enemy
class_name PotatoEnemy



@onready var potato_scene = $potato

func get_class():
	return "PotatoEnemy"

func _ready() -> void:
	enemy_val = 750

func anim_process():
	potato_scene.get_node("AnimationPlayer").playback_speed = velocity.length()

func run_attack_anim():
	pass
	# $carrot_man/AnimationTree1["parameters/playback"].travel("carrotattack")

func _on_attack_timer_timeout():
	pass
	# if targeted_player != null:
	# 	var dist = targeted_player.global_position.distance_to(global_position)
	# 	# print(str(dist))
	# 	if dist< 5:
	# 		targeted_player.take_damage(DAMAGE)
	# 	current_behavior = "targeting_player"

func local_death():
	pass
