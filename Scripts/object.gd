extends RigidBody2D

signal destroyed_by_player
export var health = 50 setget set_health
export var damage = 50

onready var player = get_tree().get_root().get_node("Game/Player")

func _ready():
	add_to_group("object")
	randomize()
	
	self.set_angular_velocity(rand_range(-5, 5))
	
	connect("body_entered", self, "_on_body_enter")
	connect("destroyed_by_player", self, "object_destroyed")
	
	yield(get_node("VisibilityNotifier2D"), "screen_exited")
	queue_free()

func _on_body_enter(other):
	if other.is_in_group("player"):
		other.health -= damage
		global.create_explosion(other.position)
		self.health -= health

func on_hit():
	if health <= 0:
		emit_signal("destroyed_by_player")

func object_destroyed():
	if player:
		player.boost = 10
		player.score = 50 / 2

func set_health(new_value):
	health = new_value
	if health <= 0:
		global.create_explosion(position)
		queue_free()