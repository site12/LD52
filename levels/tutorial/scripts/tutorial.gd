extends Node3D


@onready var player = preload("res://entities/players/player.tscn")
@onready var p = player.instantiate()


var spawned = false
var purchased = false
var ready_for_plot = false

func _ready():
	p.points = 500

func _unhandled_key_input(event):
	if event.is_pressed() and not spawned:
		
		add_child(p)
		
		p.global_transform = $spawn_loc.global_transform
		$tutcam_intro.current = false
		spawned = true
		$tut/screen_1.visible = false
		await get_tree().create_timer(5).timeout
		$tut/screen_1.visible = false
		$tut/screen_2.visible = true
		$tutcam_seeds.current = true
		await get_tree().create_timer(7).timeout
		$tutcam_seeds.queue_free()
		$tutcam_intro.queue_free()
		$tut/screen_2.visible = false
	if Input.is_action_just_released("next_weapon") and purchased and ready_for_plot:
		$tut/screen_3.visible = false
		$tutcam_plot.queue_free()
		
func _physics_process(delta):
	if p.points != 500 and not purchased:
		await get_tree().create_timer(1).timeout
		$tut/screen_3.visible = true
		$tutcam_plot.current = true
		purchased = true
		
