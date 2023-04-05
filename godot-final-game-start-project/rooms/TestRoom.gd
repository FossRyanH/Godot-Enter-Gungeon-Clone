extends YSort

onready var spawner := $Mobs/MobSpawn


func _ready() -> void:
	spawner.spawn()
