extends Control

onready var restart_button := $CenterContainer/VBoxContainer/RestartButton
onready var quit_button := $CenterContainer/VBoxContainer/QuitButton

var game_level = "res://rooms/GameLevel.tscn"


func _ready() -> void:
	restart_button.connect("button_down", self, "on_Restart_button_clicked")
	quit_button.connect("button_down", self, "on_Quit_button_clicked")


func on_Restart_button_clicked() -> void:
	get_tree().change_scene(game_level)


func on_Quit_button_clicked() -> void:
	get_tree().quit()
