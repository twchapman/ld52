extends KinematicBody2D

var gravity = ProjectSettings.get("physics/2d/default_gravity")
var jumpSpeed = 1700
var walkSpeed = 310
var grounded = true

var velocity = Vector2(0, 0)

var initialPosition = Vector2.ZERO

onready var Global_ = get_node("/root/Global")

func _ready():
	initialPosition = position
	Global_.hitter = self

func reset():
	position = initialPosition
	velocity = Vector2.ZERO
	grounded = true
	$Club.scale.x = 1

func _physics_process(delta):
	if not Global_.playing:
		return
	if Input.is_action_just_pressed("hitter_jumpswing"):
		if grounded:
			velocity.y = -jumpSpeed
			grounded = false
			$JumpSound.play()
		elif $Club.canSwing:
			$Club.swing()
	if grounded:
		if Input.is_action_pressed("hitter_left"):
			velocity.x = -walkSpeed
		elif Input.is_action_pressed("hitter_right"):
			velocity.x = walkSpeed
		else:
			velocity.x = 0
	if velocity.x > 0:
			#self.scale.x = 1
			$Club.scale.x = 1
	elif velocity.x < 0:
			#self.scale.x = -1
			$Club.scale.x = -1

	velocity.y += gravity
	velocity = move_and_slide(velocity)
	if get_slide_count() > 0:
		grounded = true
	
