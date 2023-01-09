extends Enemy
class_name CarrotEnemy



@onready var carrot_scene = $carrot_man

func get_class():
	return "CarrotEnemy"

func _ready() -> void:
	enemy_val = 750

func anim_process():
	if velocity.length() > 0 and $timers/attack_timer.is_stopped():
		$carrot_man/AnimationTree1["parameters/playback"].travel("carrotrun1")

func run_attack_anim():
	$carrot_man/AnimationTree1["parameters/playback"].travel("carrotattack")

func _on_attack_timer_timeout():
	var dist = targeted_player.global_position.distance_to(global_position)
	print(str(dist))
	if dist< 5:
		targeted_player.take_damage(DAMAGE)
	current_behavior = "targeting_player"

func local_death():
	pass
