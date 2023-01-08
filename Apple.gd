extends Area2D

var attached = true
var velocity = Vector2.ZERO
var gravity_ = ProjectSettings.get("physics/2d/default_gravity")
var initialPos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	initialPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not attached:
		velocity.y += gravity_ * .25
		position += velocity * delta
	if Input.is_key_pressed(KEY_TAB):
		position = initialPos
		attached = true
		velocity = Vector2.ZERO

func _on_Apple_area_entered(area):
	if area.name == "Club":
		var hdirection = sign(global_position.x - area.global_position.x)
		var vdirection = sign(global_position.y - area.global_position.y)
		velocity += Vector2(hdirection, vdirection) * 400
		attached = false
	
	if area.name == "Basket":
		queue_free()

func _on_Apple_body_entered(body):
	if body.name == "Ground":
		attached = true
		velocity = Vector2.ZERO
