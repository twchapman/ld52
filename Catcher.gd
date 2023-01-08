extends Area2D

var velocity = Vector2.ZERO
var walkSpeed = 650

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
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
