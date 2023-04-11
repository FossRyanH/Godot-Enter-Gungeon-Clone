extends YSort

# List of rooms to spawn!
export(Array, PackedScene) var rooms := [preload("BaseRoom.tscn"), preload("Room01.tscn"), preload("Room02.tscn"), preload("Room03.tscn"), preload("RoomFinal.tscn")]
# Width of the grid!
export var grid_width := 3
# Height of the grid!
export var grid_height := 3
# Size of the rooms, all should be the same dimensions
export var room_size := Vector2(13, 13) * 128

onready var pause_screen := $UILayer/PauseScreen
onready var music_player := $MusicPlayer


func _ready() -> void:
	randomize()
	pause_screen.hide()
	music_player.play()
	generate_level()


func generate_level() -> void:
	# For each (x, y) in the grid:
	# Spawn a room,
	# Set room position @ room_size * (x, y)
	# If the room is the first room spawned, spawn a player and items
	# Else spawn mobs and pickups
	# Gotta hide bridges if:
	# x is 0 or if x is the last x in sequence hide bridge on the right side of room.
	# if Y is 0 hide top bridge, or if y is the last y sequence hide thos bridges.
	var last_room_index := (grid_width * grid_height) - 1
	var current_room_index := 0
	for x in grid_width:
		for y in grid_height:
			var room_pos := Vector2(x, y)
			var RoomScene: PackedScene = rooms[randi() % rooms.size()]
			var room: BaseRoom = RoomScene.instance()
			room.global_position = room_size * room_pos
			add_child(room)
			
			if current_room_index == 0:
				room.spawn_robot()
				room.spawn_items()
			elif current_room_index == last_room_index:
				room.spawn_teleporter()
				room.spawn_mobs()
			else:
				room.spawn_items()
				room.spawn_mobs()
			
			if x == 0:
				room.hide_left_bridge()
			elif x == grid_width - 1:
				room.hide_right_bridge()
			if y == 0:
				room.hide_top_bridge()
			elif y == grid_height -1:
				room.hide_bottom_bridge()
			current_room_index += 1
