extends Bullet

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var particles := $IceSplashParticles2D


func _ready() -> void:
	anim_player.play("spawn")
	anim_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


func _destroy() -> void:
	_disable()
	particles.emitting = true
	_audio.play()
	anim_player.play("destroy")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "destroy":
		queue_free()
