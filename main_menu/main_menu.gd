##this script handles the site12 intro and gets us to the main menu.

extends Node

func _ready():
	$AnimationPlayer.play("idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$main_menu.visible = true
	$credits.visible = false


func _on_quit_2_button_down():
	$main_menu.visible = false
	$credits.visible = true


func _on_back_button_down():
	$main_menu.visible = true
	$credits.visible = false



func _on_play_button_up():
	get_tree().change_scene_to_file("res://levels/farm map/farm_map.tscn")


func _on_tut_button_up():
	get_tree().change_scene_to_file("res://levels/tutorial/tutorial.tscn")


func _on_quit_button_up():
	get_tree().quit()
