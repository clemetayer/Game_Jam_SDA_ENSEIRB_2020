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

const purpleProjectile = preload("res://Scenes/PurpleProjectile.tscn")
const whiteProjectile = preload("res://Scenes/WhiteProjectile.tscn")
const orangeProjectile = preload("res://Scenes/OrangeProjectile.tscn")

var velocity = Vector2()
var isFacingRight = true
var animationDone = true
var isPlayingDialog = false
var currentProjectile = 0 # 0 = None, 1 = Orange, 2 = Purple, 3 = White


# Called when the node enters the scene tree for the first time.
func _ready():
	currentProjectile = global.lastProjectile

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not isPlayingDialog):
		inputManager()
	elif((not get_node("OrangeDialog").get("StartDialog"))
		and (not get_node("PurpleDialog").get("StartDialog"))
		and (not get_node("WhiteDialog").get("StartDialog"))):
		isPlayingDialog = false

func playOrangeDialog():
	if(not isFacingRight):
		isFacingRight = true
		self.scale.x = self.scale.x * -1
	get_node("OrangeDialog").StartDialog()
	isPlayingDialog = true

func playPurpleDialog():
	if(not isFacingRight):
		isFacingRight = true
		self.scale.x = self.scale.x * -1
	get_node("PurpleDialog").StartDialog()
	isPlayingDialog = true

func playWhiteDialog():
	if(not isFacingRight):
		isFacingRight = true
		self.scale.x = self.scale.x * -1
	get_node("WhiteDialog").StartDialog()
	isPlayingDialog = true

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
	
	if(Input.is_action_just_pressed("select_orange")):
		if(global.unlockedOrange):
			global.lastProjectile = 1
			currentProjectile = 1
	elif(Input.is_action_just_pressed("select_purple")):
		if(global.unlockedPurple):
			global.lastProjectile = 1
			currentProjectile = 2
	elif(Input.is_action_just_pressed("select_white")):
		if(global.unlockedWhite):
			global.lastProjectile = 1
			currentProjectile = 3
	
	if(Input.is_action_just_pressed("shoot")):
		if(currentProjectile == 1):
			var orange_instance = orangeProjectile.instance()
			get_parent().add_child(orange_instance)
			if(isFacingRight):
				orange_instance.throw(Vector2(1,0),position,30)
			else:
				orange_instance.throw(Vector2(-1,0),position,30)
		elif(currentProjectile == 2):
			var purple_instance = purpleProjectile.instance()
			get_parent().add_child(purple_instance)
			if(isFacingRight):
				purple_instance.throw(Vector2(1,0),position,30)
			else:
				purple_instance.throw(Vector2(-1,0),position,30)
		elif(currentProjectile == 3):
			var white_instance = whiteProjectile.instance()
			get_parent().add_child(white_instance)
			if(isFacingRight):
				white_instance.throw(Vector2(1,0),position,30)
			else:
				white_instance.throw(Vector2(-1,0),position,30)

	move_and_slide(velocity,FLOOR)
	velocity.y += GRAVITY

func _on_AnimatedSprite_animation_finished():
	animationDone = true


func _on_Diggo_tree_entered():
	position = global.spawnPoint
