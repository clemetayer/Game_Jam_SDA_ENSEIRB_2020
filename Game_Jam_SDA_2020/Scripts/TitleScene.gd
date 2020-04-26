extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const scene1 = preload("res://Scenes/Scene1.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	global.unlockedPurple = false
	global.unlockedWhite = false
	global.unlockedOrange = false 
	global.lastProjectile = 0

func _on_PlayButton_pressed():
	global.spawnPoint = Vector2(722,1044)
	get_tree().change_scene_to(scene1)

func _on_ExitButton_pressed():
	get_tree().quit()
