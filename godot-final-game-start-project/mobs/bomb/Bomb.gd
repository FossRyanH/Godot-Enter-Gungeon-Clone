extends Mob

export var shockwave_damage := 2

onready var shockwave := $ShockArea


func _ready() -> void:
	_animation_player.connect("animation_finished", self, "on_AnimationPlayer_animation_finished")
	shockwave.connect("body_entered", self, "on_ShockWave_emitted")


func _on_AttackArea_body_entered(body: Robot) -> void:
	_sprite_alert.visible = true
	_animation_player.play("will_explode")
	

func on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "will_explode":
		_disable()
		_die_sound.play()
		_animation_player.play("explode")
	elif anim_name == "explode":
		queue_free()

func on_ShockWave_emitted(body: Node) -> void:
	if body == self:
		return
	if body.has_method("take_damage"):
		body.take_damage(damage)
