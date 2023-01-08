extends Node3D


@onready var player = preload("res://entities/players/player.tscn")
@onready var p = player.instantiate()


@onready var cam1 = $tutcam_intro
@onready var cam2 = $tutcam_seeds
@onready var cam3 = $tutcam_plot

var spawned = false
var purchased = false
var planted = false

func _unhandled_key_input(event):
	if event.is_pressed() and not spawned:
		
		add_child(p)
		
		p.global_transform = $spawn_loc.global_transform
		$tutcam_intro.current = false
		spawned = true
		$tut/screen_1.visible = false
		await get_tree().create_timer(3.5).timeout
		$tut/screen_1.visible = false
		$tut/screen_2.visible = true
		$tutcam_seeds.current = true
		await get_tree().create_timer(12).timeout
		cam2.queue_free()
		cam1.queue_free()
		$tut/screen_2.visible = false

func _physics_process(delta):
	if Global.money != 1000 and not purchased:
		purchased = true
		await get_tree().create_timer(1.5).timeout
		$tut/screen_3.visible = true
		cam3.current = true
		await get_tree().create_timer(17).timeout
		$tut/screen_3.visible = false
		cam3.current = false
		
		
	if Global.money != 1000 and p.seeds[Global.SeedType.CARROT]==0:
		planted = true
		await get_tree().create_timer(1).timeout
		$tut/screen_4.visible = true
		$AnimationPlayer.play("fade")
		
		
		
func phase_1():
	pass

func phase_2():
	pass

func phase_3():
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade":
		get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
