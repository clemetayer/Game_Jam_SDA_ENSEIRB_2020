extends Area2D


# Declare member variables here. Examples:
var LaunchDirection
var LaunchSpeed
var LaunchPlayer

func throw(Direction, Position, Speed):
	LaunchDirection = Direction
	LaunchSpeed = Speed
	self.position = Position

# Called when the node enters the scene tree for the first time.
func _ready():
	LaunchDirection = Vector2(0,0)
	LaunchSpeed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(LaunchSpeed * LaunchDirection)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
