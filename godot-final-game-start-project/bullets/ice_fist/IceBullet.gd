extends Bullet

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var particles := $IceSplashParticles2D


func _ready() -> void:
	anim_player.play("spawn")
	_audio.connect("finished", self, "queue_free")


func _destroy() -> void:
	_disable()
	particles.emitting = true
	_audio.play()
	anim_player.play("destroy")
