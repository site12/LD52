extends Enemy
class_name PotatoEnemy



@onready var potato_scene = $potato

func get_class():
	return "PotatoEnemy"

func _ready() -> void:
	enemy_val = 750
	potato_scene.get_node("AnimationPlayer").play("Potato/roll")

var next_loc

var on_cooldown = false

func _physics_process(delta) -> void:
	$mesh/health.text = str(health)
	if not health <=0:
		if current_behavior == "targeting_player":
			update_target_location(get_closest_player_loc())
		var current_loc = global_transform.origin
		
		if not $timers/attack_timer.is_stopped():
			if current_behavior != "rolling":
				current_behavior = "rolling"
				next_loc = navagent.get_next_location()
		else:

			next_loc = navagent.get_next_location()
		
		var new_velocity = (next_loc - current_loc).normalized() * SPEED
		
		navagent.set_velocity(new_velocity)
		
	anim_process()

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity,.25)

	if $timers/attack_timer.is_stopped():
		rotation.y = acos(velocity.normalized().x)
		if velocity.normalized().z > 0:
			rotation.y *= -1
	else:
		
		rotation.y = acos(velocity.normalized().x)
		if velocity.normalized().z > 0:
			rotation.y *= -1
	if not current_behavior == "stopped":
		move_and_slide()

func _on_navigation_agent_3d_target_reached():
	$timers/attack_timer.start()
	run_attack_anim()
		


func anim_process():
	if targeted_player != null and not on_cooldown:
		var dist = targeted_player.global_position.distance_to(global_position)
		# print(str(dist))
		if dist< 1.5:
			targeted_player.take_damage(DAMAGE)
			on_cooldown = true
			$timers/cool_down_timer.start()
	potato_scene.get_node("AnimationPlayer").playback_speed = velocity.length()*.3

func run_attack_anim():
	velocity *= 5
	pass
	# $carrot_man/AnimationTree1["parameters/playback"].travel("carrotattack")

func _on_attack_timer_timeout():
	
	current_behavior = "targeting_player"

func local_death():
	pass

func _on_cool_down_timer_timeout() -> void:
	on_cooldown = false
