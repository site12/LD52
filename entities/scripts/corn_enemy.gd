extends Enemy
class_name CornEnemy



# @onready var carrot_scene = $carrot_man

func _ready() -> void:
	enemy_val = 750

func anim_process():
	if velocity.length() > 0 and $timers/attack_timer.is_stopped():
		$corn_model/AnimationTree["parameters/playback"].travel("cornrun2")

func run_attack_anim():
	$corn_model/AnimationTree["parameters/playback"].travel("cornattack")
