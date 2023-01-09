extends Area2D

var velocity = Vector2.ZERO
var walkSpeed = 475

var initialPosition = Vector2.ZERO

onready var Global_ = get_node("/root/Global")

func _ready():
	initialPosition = position
	Global_.catcher = self

func reset():
	position = initialPosition
	velocity = Vector2.ZERO
	self.scale.x = 1

func _physics_process(delta):
	if not Global_.playing:
		return
	if Input.is_action_pressed("catcher_left"):
		velocity.x = -walkSpeed
	elif Input.is_action_pressed("catcher_right"):
		velocity.x = walkSpeed
	else:
		velocity.x = 0
	if velocity.x > 0:
		self.scale.x = -1
	elif velocity.x < 0:
		self.scale.x = 1
	position += velocity * delta
