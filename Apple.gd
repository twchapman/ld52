extends Area2D

var attached = true
var scored = false
var velocity = Vector2.ZERO
var gravity_ = ProjectSettings.get("physics/2d/default_gravity")
var initialPos = Vector2.ZERO

onready var Global_ = get_node("/root/Global")

onready var HitSound = preload("res://Sounds/hit.wav")
onready var MissSound = preload("res://Sounds/miss.wav")
onready var PickupSound = preload("res://Sounds/pickup.wav")

onready var ScoreBlip = preload("res://ScoreBlip.tscn")

func _ready():
	initialPos = position
	reset()
	Global_.addApple(self)
	
func reset():
	position = initialPos
	attached = true
	scored = false
	velocity = Vector2.ZERO
	visible = true

func _process(delta):
	if not attached:
		velocity.y += gravity_ * .25
		position += velocity * delta

func _on_Apple_area_entered(area):
	if area.name == "Club" and attached:
		var hdirection = sign(global_position.x - area.global_position.x)
		var vdirection = sign(global_position.y - area.global_position.y)
		velocity += Vector2(hdirection, vdirection) * 400
		attached = false
		$AudioStreamPlayer.stream = HitSound
		$AudioStreamPlayer.play()
	
	if area.name == "Basket" and not scored:
		Global_.addPoint()
		Global_.removeApple()
		visible = false
		scored = true
		velocity = Vector2.ZERO
		$AudioStreamPlayer.stream = PickupSound
		$AudioStreamPlayer.play()
		var blip = ScoreBlip.instance()
		blip.position = global_position - Vector2(24,  40)
		get_tree().root.add_child(blip)

func _on_Apple_body_entered(body):
	if body.name == "Ground" and not scored:
		attached = true
		velocity = Vector2.ZERO
		Global_.removeApple()
		$AudioStreamPlayer.stream = MissSound
		$AudioStreamPlayer.play()
