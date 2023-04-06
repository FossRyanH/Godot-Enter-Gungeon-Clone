extends YSort

onready var spawners := [$Mobs/MobSpawner, $Mobs/MobSpawner2, $Mobs/MobSpawner3, $Mobs/MobSpawner4, $Mobs/MobSpawner5]
onready var item_spawners := [$Items/ItemSpawner, $Items/ItemSpawner2, $Items/ItemSpawner3]
onready var player_spawner := $PlayerSpawner
onready var teleporter := $TeleportSpawner


func _ready() -> void:
	for spawn in spawners.size():
		spawners[spawn].spawn()
	for item in item_spawners.size():
		item_spawners[item].spawn()
	player_spawner.spawn()
	teleporter.spawn()
