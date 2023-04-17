# The pause screen. It should exist in the main game scene but start hidden.
#
# Pressing the "pause" input action will show this screen and pause everything
# else.
extends Control

onready var _button_continue := $CenterContainer/VBoxContainer/ContinueButton
onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	_button_continue.connect("button_down", self, "on_Continue_button_clicked")
	_button_quit.connect("button_down", self, "on_Quit_button_clicked")
	_button_restart.connect("button_down", self, "on_Restart_button_clicked")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_toggle"):
		if not visible:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false


func on_Quit_button_clicked() -> void:
	get_tree().quit()


func on_Restart_button_clicked() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false


func on_Continue_button_clicked() -> void:
	hide()
	get_tree().paused = false
