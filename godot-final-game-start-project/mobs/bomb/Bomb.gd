extends Mob

# The amount of damage the shockwave ill deal instead of full damage
export(int, 1, 4, 1) var shockwave_damage := 1

# Get a handle to the shockarea
onready var shockwave_area := $ShockArea


func _ready() -> void:
	_animation_player.connect("animation_finished", self, "on_AnimationPlayer_animation_finished")
	shockwave_area.connect("body_entered", self, "on_ShockArea_body_entered")


func on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "will_explode":
		_disable()
		_die_sound.play()
		_animation_player.play("explode")
	elif anim_name == "explode":
		queue_free()


func _on_AttackArea_body_entered(body: Robot) -> void:
	if body is Robot:
		_animation_player.play("will_explode")


func on_ShockArea_body_entered(_body: Node) -> void:
	if _body == self:
		return
	if _body.has_method("take_damage"):
		_body.take_damage(damage)
