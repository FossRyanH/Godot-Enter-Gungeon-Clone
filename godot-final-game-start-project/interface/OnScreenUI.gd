## Takes care of showing the UI. Should be always present. Uses the global Events
## autoload to know when to update
extends Control

var score := 0


onready var health_bar := $HealthBar
onready var score_label := $ScoreLabel


func _ready() -> void:
	# Set the score to 0 initially
	set_score(0)
	
	# Connect the signals to the appropriate channels
	Events.connect("mob_died", self, "on_Events_mob_died")
	Events.connect("player_health_changed", self, "on_Player_health_changed")


func set_score(new_score: int) -> void:
	score = new_score
	score_label.text = str(score).pad_zeros(5)


func on_Events_mob_died(mob_score_value: int) -> void:
	set_score(score + mob_score_value)


func on_Player_health_changed(health: int) -> void:
	health_bar.health = health
