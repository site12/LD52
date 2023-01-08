##this script handles the site12 intro and gets us to the main menu.

extends Node

func _on_video_stream_player_finished():
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
