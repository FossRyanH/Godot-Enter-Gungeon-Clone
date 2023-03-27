extends KinematicBody2D


onready var _tween := $Tween


func take_damage(damage = 1,element = "Neutral"):
	_tween.interpolate_property(self,"rotation",-1,0,0.8,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	_tween.start()
	match element:
		"FIRE":
			pass
		"THUNDER":
			pass
		"ICE":
			pass
