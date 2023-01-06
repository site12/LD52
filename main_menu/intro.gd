extends Node

@onready var video_intro:VideoStreamPlayer = $intro_screen/site12_intro
@onready var anim_player:AnimationPlayer = $animations/anim_player

func _on_site_12_intro_finished():
	anim_player.play("godot_splash")

