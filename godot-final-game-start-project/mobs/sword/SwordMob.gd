## Sword mob
extends Mob

# How fast the sword charges during attacks
export var attack_speed := 1200.0

onready var _line_of_sight := $RayCast2D
onready var _collision_shape := $CollisionShape2D
onready var _hurtbox := $HurtBox


# We keep track of the Sword's state, so we can switch back 
# to normal after an attack
var _is_in_attack_state := false
# When attacking, this will be the direction of the attack
var _charge_direction := Vector2()


func _ready() -> void:
	_hurtbox.connect("body_entered", self, "_on_HurtBox_body_entered")


# When the player enters the detection area
func _on_DetectionArea_body_entered(body: Robot) -> void:
	_target = body
	_line_of_sight.enabled = true


# When the player exists the detection area
func _on_DetectionArea_body_exited(_body: Robot) -> void:
	_target = null
	_line_of_sight.enabled = false


# lerps both the collision shape and the sprite towards the global position 
# provided.
func _rotate_towards(pos: Vector2, factor := 0.5) -> void:
	var rot: float = lerp(rotation, pos.angle_to_point(global_position), factor)
	_sprite.rotation = rot
	_collision_shape.rotation = rot
	_hurtbox.rotation = rot


func does_see_target() -> bool:
	return _line_of_sight.is_colliding() and _line_of_sight.get_collider() == _target


func _physics_process(delta: float) -> void:
	
	if not _target:
		return
	
	_rotate_towards(_target.global_position, 1)
	_line_of_sight.cast_to = _target.global_position - global_position
	
	if _target_within_range:
		if _is_in_attack_state:
			_velocity = attack_speed * _charge_direction
			_velocity = move_and_slide(_velocity)
		else:
			# if the target is within attack range
			# we always orbit no matter what
			orbit_target()
			# we can call this on every tick, it's not a problem; if the 
			# `_before_attack_timer` is already started, nothing will happen
			# (therefore, on most frames, this function does nothing)
			_prepare_to_attack()
	else:
		# Target is not within attack range, we follow it
		follow(_target.global_position)


# If the wind-up timer isn't started, we start the wind-up timer.
# otherwise, we do nothing
func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()
	_enter_attack_state()


# The wind-up timer has finished, we can attack
func _on_BeforeAttackTimer_timeout() -> void:
	# The target might have exited the range while the timeout was running,
	# so we check again
	if not _target:
		_exit_attack_state()
		return
	_charge_direction = global_position.direction_to(_target.global_position)
	_cooldown_timer.start()


# Called when the attack was launched and recovered from. The mob is ready to 
# attack again now
func _on_CoolDownTimer_timeout() -> void:
	_exit_attack_state()


func _enter_attack_state() -> void:
	_is_in_attack_state = true
	_sprite_alert.visible = true


func _exit_attack_state() -> void:
	_sprite_alert.visible = false
	_charge_direction = Vector2()
	_is_in_attack_state = false


func _on_HurtBox_body_entered(body: Node) -> void:
	if body is Robot:
		body.take_damage(damage)
		_exit_attack_state()
