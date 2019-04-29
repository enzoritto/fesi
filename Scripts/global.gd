extends Node2D

const explosion_scene = preload("res://Scenes/explosion.tscn")

func create_explosion(position):
	var explosion = explosion_scene.instance()
	explosion.position = position
	get_parent().add_child(explosion)
