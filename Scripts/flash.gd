extends Sprite

func _ready():
	get_node("AnimationPlayer").play("Fade_out")
	
	yield(get_node("AnimationPlayer"), "animation_finished")
	queue_free()
