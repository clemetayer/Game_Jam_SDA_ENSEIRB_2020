extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_treasureChest_body_entered(body):
	if body.is_in_group("Player"):
		print("Treasure chest found !")
		get_node("AnimatedSprite").play("default")


func _on_AnimatedSprite_animation_finished():
	get_node("AnimatedSprite").stop()
	get_tree().change_scene("res://Scenes/GameDone.tscn")
