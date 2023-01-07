#the hoe class, extends from gun

extends Gun

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	#handle_animations()
	#walk()
	ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")

#uses the player's current state to play animations accordingly
func handle_animations():
	
	
	if current_state == player_state[0]:
		anim_player.play("hoe/idle")
		pass
	elif current_state == player_state[1]:
		anim_player.play("hoe/walk")
		pass
	elif current_state == player_state[2]:
		anim_player.play("hoe/use_hoe")
		pass
	elif current_state == player_state[3]:
		pass
		#anim_player.play("gr_11_ads_anims/ads_stop")
	elif current_state == player_state[4]:
		pass
		#anim_player.play("gr_11_anims/reload")
	

