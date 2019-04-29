extends KinematicBody2D

var fire_rate_timer = Timer.new()

export var fire_rate = .3
export var health = 200 setget set_health
export var boost = 100 setget set_boost
export var damage = 25
var score = 0 setget set_score

var can_shoot = true
var pull_strength = 5

const laser_scene = preload("res://Scenes/laser.tscn")

func _ready():
	add_to_group("player")
	
	# Configure Fire-rate timer
	self.add_child(fire_rate_timer)
	fire_rate_timer.set_one_shot(true)
	fire_rate_timer.set_wait_time(fire_rate)
	fire_rate_timer.connect("timeout", self, "_can_shoot")
	
	set_physics_process(true)
	set_process(true)

func _physics_process(delta):
	var motion = (get_global_mouse_position().x - self.position.x) * 0.2
	var pull = pull_strength * delta
	translate(Vector2(motion, pull) * delta * 50)
	
	var view_size = get_viewport_rect().size
	var pos = self.position
	pos.x = clamp(pos.x, 30, view_size.x - 30)
	self.position = pos

func _process(delta):
	if Input.is_action_pressed("boost") && boost > 0:
		boost -= 1
		pull_strength = -50
		get_node("AnimatedSprite").position.y = 15
		get_node("AnimatedSprite").play("boost")
		get_tree().get_root().get_node("Game/GUI/Boost").set_value(boost)
	elif Input.is_action_pressed("shoot") && can_shoot:
		shoot()
	else:
		pull_strength = 10
		get_node("AnimatedSprite").position.y = 0
		get_node("AnimatedSprite").play("default")

func shoot():
	can_shoot = false
	fire_rate_timer.start()
	
	# Create laser
	var pos_left = get_node("Cannons/Left").global_position
	var pos_right = get_node("Cannons/Right").global_position
	create_laser(pos_left)
	create_laser(pos_right)

func create_laser(pos):
	var laser = laser_scene.instance()
	laser.position = pos
	get_tree().get_root().get_node("Game").add_child(laser)

func set_health(new_value):
	health = new_value
	get_tree().get_root().get_node("Game/GUI/Health").set_value(health)
	if health <= 0:
		global.create_explosion(position)
		queue_free()

func set_boost(new_value):
	if boost < 100:
		boost += new_value
		get_tree().get_root().get_node("Game/GUI/Boost").set_value(boost)

func set_score(new_value):
	score += new_value
	get_tree().get_root().get_node("Game/GUI/Score").set_text(str(score))

func _can_shoot():
	can_shoot = true