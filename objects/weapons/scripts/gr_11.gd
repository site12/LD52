#the GR11 class that inherits from the base gun class.

extends Gun

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	handle_animations()
	walk()
	ammo_count()

#uses the player's current state to play animations accordingly
func handle_animations():
	
	
	if current_state == player_state[0]:
		anim_player.play("gr_11_anims/idle")
	elif current_state == player_state[1]:
		anim_player.play("gr_11_anims/walk")
	elif current_state == player_state[2]:
		if not aiming:
			anim_player.play("gr_11_anims/shoot")
		else:
			anim_player.play("gr_11_ads_anims/ads_shoot")
	elif current_state == player_state[3]:
		anim_player.play("gr_11_ads_anims/ads_stop")
	elif current_state == player_state[4]:
		anim_player.play("gr_11_anims/reload")
	


