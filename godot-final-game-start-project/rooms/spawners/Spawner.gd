class_name Spawner
extends Sprite

export(Array, PackedScene) var list := []


func _ready() -> void:
	randomize()
	texture = null


func spawn() -> void:
	if not list:
		return
	# Get an random scene from the list array.
	var random_scene_index := randi() % list.size()
	var scene: PackedScene = list[random_scene_index]
	
	# If the array is missing data do nothing.
	if not scene:
		return
	var node: Node2D = scene.instance()
	get_parent().add_child(node)
	node.global_position = global_position
