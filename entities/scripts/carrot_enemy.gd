extends Enemy
class_name CarrotEnemy



@onready var carrot_scene = $carrot_man

func _ready() -> void:
	enemy_val = 750

func anim_process():
	if velocity.length() > 0 and $timers/attack_timer.is_stopped():
		$carrot_man/AnimationTree1["parameters/playback"].travel("carrotrun1")

func run_attack_anim():
	$carrot_man/AnimationTree1["parameters/playback"].travel("carrotattack")
