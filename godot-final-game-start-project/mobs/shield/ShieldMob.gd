extends Mob

onready var cannon := $Cannon
onready var raycast := $RayCast2D


func prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()

# Windup is finished, now we strike!
func _on_BeforeAttackTimer_timeout() -> void:
	# If there is no target at the time the timer was running, do nothing
	if not _target:
		return
	# Otherwise shoot at the target
	cannon.shoot_at_target(_target)
	_cooldown_timer.start()


func _physics_process(delta: float) -> void:
	if not _target:
		return
	else:
		raycast.look_at(_target.global_position)
		raycast.force_raycast_update()
		if raycast.get_collider() == _target:
			follow(_target.global_position)
		else:
			orbit_target()
	
		if _target_within_range:
			orbit_target()
			prepare_to_attack()
		else:
			return


func _on_DetectionArea_body_exited(_body: Robot) -> void:
	pass
