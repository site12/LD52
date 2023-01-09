extends Enemy
class_name CornEnemy



# @onready var carrot_scene = $carrot_man

func _ready() -> void:
	enemy_val = 80

func anim_process():
	if velocity.length() > 0 and $timers/attack_timer.is_stopped():
		$corn_model/AnimationTree["parameters/playback"].travel("cornrun2")

func run_attack_anim():
	$corn_model/AnimationTree["parameters/playback"].travel("cornattack")

func _on_attack_timer_timeout():
	if targeted_player != null:
		var dist = targeted_player.global_position.distance_to(global_position)
		# print(str(dist))
		if dist< 8:
			targeted_player.take_damage(DAMAGE)
		
	$explosion.set_emitting(true)
	$corn_model.visible = false
	await get_tree().create_timer(2).timeout

	queue_free()

	
