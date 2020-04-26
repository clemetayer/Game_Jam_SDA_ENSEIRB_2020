extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").play("default")

func _on_OrangePowerup_body_entered(body):
	if body.is_in_group("Player"):
		global.unlockedOrange = true
		body.playOrangeDialog()
		queue_free()
