extends CharacterBody3D
class_name Zombie


#constants for speed and health
const SPEED:float = 1.5
var health:float = 1.0

#zombie's current state
var current_behavior = "targeting_window"

#where the zombie will target
var targeted_window:Barrier = null
var targeted_player:Player = null

#onready variables
var navmesh:NavigationMesh
@onready var navagent:NavigationAgent3D = get_node("NavigationAgent3D")

#getters/setters
func set_navmesh(nav_mesh:NavigationMesh) -> void:
	navmesh = nav_mesh

func get_navmesh() -> NavigationMesh:
	return navmesh

# updates the target location every frame with a player location and moves them closer to it.
func _physics_process(delta) -> void:
	$mesh/health.text = str(health)
	if not health <=0:
		if current_behavior == "targeting_window":
			update_target_location(get_window_loc())
		elif current_behavior == "targeting_player":
			update_target_location(get_closest_player_loc())
		var current_loc = global_transform.origin
		var next_loc = navagent.get_next_location()
	
		var new_velocity = (next_loc - current_loc).normalized() * SPEED
		
		navagent.set_velocity(new_velocity)
		
		

#this handles the avoidance of other zombies
func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity,.25)
	if not current_behavior == "stopped":
		move_and_slide()

#sets the navagent target to a target vector3 location
func update_target_location(target_loc)-> void:
	navagent.set_target_location(target_loc)

#returns the location of the targeted window
func get_window_loc()-> Vector3:
	return targeted_window.global_transform.origin
	
#if a closest player exists, then set the location. if not the zombie will stand still
func get_closest_player_loc()-> Vector3:
	var loc:Vector3 = global_transform.origin
	var players = get_tree().get_nodes_in_group("players")
	if players.size() >0:
		var nearest_player_loc = players[0].get_player_location()
		var nearest_player:Player = players[0]
		for player in players:
			if player.get_player_location().distance_to(global_transform.origin) < nearest_player_loc.distance_to(global_transform.origin):
				nearest_player_loc = player.get_player_location()
				nearest_player = player
		targeted_player = nearest_player
		return nearest_player_loc
	return loc

#this function applies damage to the zombie and kills it if need be
func take_damage(dmg) -> bool:
	var new_health = health - dmg
	if new_health <= 0:
		health = 0
		die()
		return true
	else:
		health = new_health
	return false
	

#this function kills the zombie
func die():
	#$NavigationAgent3D.queue_free()
	$CollisionShape3D.queue_free()
	$timers/death_timer.start()
	
#this handles attacking both windows and players that are within range
func _on_navigation_agent_3d_target_reached():
	$timers/attack_timer.start()
	if current_behavior == "targeting_window":
		current_behavior = "stopped"
		

#this handles attacking both windows and players that are within range
func _on_attack_timer_timeout():
	if current_behavior == "stopped" and targeted_window != null:
		if targeted_window.get_window_health() !=0:
			targeted_window.attack_window(self,1)
		else:
			$timers/attack_timer.stop()
			targeted_window = null
			current_behavior = "targeting_player"

#this function frees the zombie object from the game
func _on_death_timer_timeout():
	self.queue_free()



