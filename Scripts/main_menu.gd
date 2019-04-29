extends Control

onready var start_button = get_node("Start button")
onready var quit_button = get_node("Quit button")

var game_scene = preload("res://Stages/game.tscn")

func _ready():
	start_button.connect("button_down", self, "start_game")
	quit_button.connect("button_down", self, "quit_game")

func start_game():
	get_tree().change_scene_to(game_scene)

func quit_game():
	get_tree().quit()
