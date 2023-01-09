extends Enemy
class_name WeedEnemy



@onready var weed_scene = $weed_idles

func get_class():
	return "WeedEnemy"

func _ready() -> void:
	enemy_val = 0

func anim_process():
	if velocity.length() > 0 and $timers/attack_timer.is_stopped():
		$weed_idles/AnimationTree.set("parameters/BlendSpace1D/blend_position", velocity.normalized().length())

func run_attack_anim():
	$weed_idles/AnimationTree["parameters/playback"].travel("weedattack")

func _on_attack_timer_timeout():
	if targeted_player != null:
		var dist = targeted_player.global_position.distance_to(global_position)
		# print(str(dist))
		if dist< 4:
			targeted_player.take_damage(DAMAGE)
		$timers/cool_down_timer.start()
		



func _on_cool_down_timer_timeout() -> void:
	current_behavior = "targeting_player"


func local_death():
	pass
