extends Node

func _ready():
	get_node("AnimatedSprite").play("default")
	yield(get_node("AnimatedSprite"), "animation_finished")
	queue_free()
