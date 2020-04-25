extends KinematicBody2D


# Declare member variables here. Examples:
# export global variables
export var SPEED = 1000
export var SPEED_DELTA = 100
export var MAX_SPEED = 1000
export var GRAVITY = 20
export var BASE_GRAVITY = 500
export var JUMP_POWER = -900
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
		if(is_on_floor()):
			velocity.x = SPEED
			velocity.y = BASE_GRAVITY
			get_node("AnimatedSprite").play("Running")
			isDigging = false
		elif(velocity.x < MAX_SPEED):
			velocity.x = velocity.x + SPEED_DELTA
		if(not isFacingRight):
			isFacingRight = true
			self.scale.x = self.scale.x * -1
	elif(Input.is_action_pressed("left")):
		if(is_on_floor()):
			velocity.x = -SPEED
			velocity.y = BASE_GRAVITY
			get_node("AnimatedSprite").play("Running")
			isDigging = false
		elif(velocity.x > -MAX_SPEED):
			velocity.x = velocity.x - SPEED_DELTA
		if(isFacingRight):
			isFacingRight = false
			self.scale.x = self.scale.x * -1
	elif(Input.is_action_pressed("dig")):
		if(is_on_floor()):
			velocity.x = 0
			velocity.y = BASE_GRAVITY
			get_node("AnimatedSprite").play("Digging")
			isDigging = true
	elif(animationDone and is_on_floor()):
		velocity.x = 0
		velocity.y = BASE_GRAVITY
		get_node("AnimatedSprite").play("Idle")
		isDigging = false
	elif(not is_on_floor()):
		if(velocity.x > 0):
			velocity.x = velocity.x - SPEED_DELTA
		elif(velocity.x < 0):
			velocity.x = velocity.x + SPEED_DELTA

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


func _on_Diggo_tree_entered():
	position = global.spawnPoint
