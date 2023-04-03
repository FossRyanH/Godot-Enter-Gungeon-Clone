class_name SpellRapidFireBolt
extends Spell


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and _cooldown_timer.is_stopped():
		_cooldown_timer.start()
		shoot()


func shoot() -> void:
	_cooldown_timer.start()
	.shoot()
