extends Area2D


# Declare member variables here. Examples:
var diggoOnBlock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(diggoOnBlock and get_parent().isDigging()):
		get_node("AnimatedSprite").play("default")
	else:
		get_node("AnimatedSprite").stop()

func _on_sandMid_breakable_body_entered(body):
	diggoOnBlock = true

func _on_sandMid_breakable_body_exited(body):
	diggoOnBlock = false

func _on_AnimatedSprite_animation_finished():
	queue_free()
