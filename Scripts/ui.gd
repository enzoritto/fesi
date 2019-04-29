extends Node

onready var player = get_node("Player")
onready var audio_streamer = get_node("AudioStreamPlayer")

# Get UI elements
onready var boost_bar = get_node("GUI/Boost")
onready var health_bar = get_node("GUI/Health")
onready var score_label = get_node("GUI/Score")
onready var final_score_label = get_node("GUI/Final score")
onready var game_over_label = get_node("GUI/Game Over")

# Get buttons
onready var quit_button = get_node("GUI/Quit")
onready var restart_button = get_node("GUI/Restart")
onready var main_menu_button = get_node("GUI/Main menu")

onready var tree = get_tree()

func _ready():
	set_process(true)
	
	restart_button.connect("button_down", self, "restart_scene")
	main_menu_button.connect("button_down", self, "load_main_menu")
	quit_button.connect("button_down", self, "quit_game")
	
	audio_streamer.connect("finished", self, "replay")

func _process(delta):
	if not has_node("Player"): # If player is dead
		game_over()
	
	if has_node("Player") && player.position.y >= 630:
		game_over()
		player.queue_free()

func game_over():
	boost_bar.hide()
	health_bar.hide()
	score_label.hide()
	final_score_label.set_text("SCORE: " + score_label.get_text())
	final_score_label.show()
	game_over_label.show()
	restart_button.show()
	main_menu_button.show()
	quit_button.show()

func replay():
	audio_streamer.play()

func restart_scene():
	tree.reload_current_scene()

func load_main_menu():
	tree.change_scene("res://Stages/main_menu.tscn")

func quit_game():
	tree.quit()