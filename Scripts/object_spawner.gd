extends Node

const object_scene = preload("res://Scenes/object.tscn")

var spawn_interval_timer = Timer.new()

export var spawn_interval = 0.5

func _ready():
	spawn_interval_timer.set_wait_time(spawn_interval)
	self.add_child(spawn_interval_timer)
	spawn_interval_timer.start()
	spawn()

func spawn():
	while true:
		randomize()
	
		var object = object_scene.instance()
		var position = Vector2()
		position.x = rand_range(30, get_viewport().get_visible_rect().size.x - 30)
		position.y = -30
		object.position = position
		get_node("../Objects").add_child(object)
		yield(spawn_interval_timer, "timeout")