#the watering can class, extends from gun

extends Gun

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")
	if interactable_object != null:
		if interactable_object.get_class() == "DirtPatch":
				interactable_object.water()
	await get_tree().create_timer($animations/AnimationPlayer.get_animation("hoe/use_hoe").length).timeout
	weapon_state = WeaponState.READY

func reload_weapon():
	if Input.is_action_just_pressed("reload") and player.in_water:
		
		
		#player is reloadng
		# current_state = player_state[4]
		$CanvasLayer/HUD/cursor.visible = false
		
		
		await get_tree().create_timer(2.5).timeout
		
		#player is finished reloading
		ammo_in_clip = 30
		# if not walking:
		# 	current_state = player_state[0]
		# else:
		# 	current_state = player_state[1]
		$CanvasLayer/HUD/cursor.visible = true

func ammo_count():
	$CanvasLayer/HUD/inventory/Label.text = str(gun_name)+"\n"+ str(ammo_in_clip)
