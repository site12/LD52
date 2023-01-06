##this script handles the site12 intro and gets us to the main menu.

extends Node


#references to the intro screen video and the animation player
@onready var video_intro:VideoStreamPlayer = $intro_screen/site12_intro
@onready var anim_player:AnimationPlayer = $animations/anim_player

#when the intro is finished it will play the godot splash screen
func _on_site_12_intro_finished():
	anim_player.play("godot_splash")
