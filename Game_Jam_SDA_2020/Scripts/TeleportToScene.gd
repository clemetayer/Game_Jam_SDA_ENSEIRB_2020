extends Area2D


# Declare member variables here. Examples:
export var teleportTo = "res://Scenes/TitleScene.tscn"
export var spawn = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TeleportToScene_body_entered(body):
	if body.is_in_group("Player"):
		global.spawnPoint = spawn
		get_tree().change_scene(teleportTo)
