extends KinematicBody2D


# Declare member variables here. Examples:
# export global variables
export var SPEED = 1000
export var GRAVITY = 20
export var JUMP_POWER = -800
export var FLOOR = Vector2(0,-1)
export var isDigging = false

var velocity = Vector2()
var isFacingRight = true
var animationDone = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputManager()

func inputManager():
	if(Input.is_action_pressed("right")):
		velocity.x = SPEED
		if(is_on_floor()):
			velocity.y = 0
			get_node("AnimatedSprite").play("Running")
			isDigging = false
		if(not isFacingRight):
			isFacingRight = true
			self.scale.x = self.scale.x * -1
	elif(Input.is_action_pressed("left")):
		velocity.x = -SPEED
		if(is_on_floor()):
			velocity.y = 0
			get_node("AnimatedSprite").play("Running")
			isDigging = false
		if(isFacingRight):
			isFacingRight = false
			self.scale.x = self.scale.x * -1
	elif(Input.is_action_pressed("dig")):
		if(is_on_floor()):
			velocity.x = 0
			velocity.y = 0
			get_node("AnimatedSprite").play("Digging")
			isDigging = true
	elif(animationDone):
		if(is_on_floor()):
			velocity.x = 0
			velocity.y = 0
			get_node("AnimatedSprite").play("Idle")
			isDigging = false

	if(Input.is_action_pressed("jump")):
		if(is_on_floor()):
			velocity.y = JUMP_POWER
			get_node("AnimatedSprite").play("Jumping")
			isDigging = false
			animationDone = false

	move_and_slide(velocity,FLOOR)
	velocity.y += GRAVITY

func _on_AnimatedSprite_animation_finished():
	animationDone = true
