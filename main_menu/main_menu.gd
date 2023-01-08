##this script handles the site12 intro and gets us to the main menu.

extends Node

func _ready():
	$main_menu.visible = true
	$credits.visible = false


func _on_quit_2_button_down():
	$main_menu.visible = false
	$credits.visible = true


func _on_back_button_down():
	$main_menu.visible = true
	$credits.visible = false


