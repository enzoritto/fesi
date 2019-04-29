extends Area2D

signal hit

export var velocity = Vector2()
onready var damage = get_tree().get_root().get_node("Game/Player").damage
const flash_scene = preload("res://Scenes/flash.tscn")

func _ready():
	set_physics_process(true)
	
	connect("body_entered", self, "_on_body_enter")
	create_flash()
	
	yield(get_node("VisibilityNotifier2D"), "screen_exited")
	queue_free()

func _physics_process(delta):
	translate(velocity * delta)

func create_flash():
	var flash = flash_scene.instance()
	flash.position = position
	get_parent().add_child(flash)

func _on_body_enter(object):
	if object.is_in_group("object"):
		object.health -= damage
		connect("hit", object, "on_hit")
		emit_signal("hit")
		create_flash()
		queue_free()