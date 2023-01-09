extends Area2D

var swingTimer = 0
var swingDuration = 0.1
export var canSwing = true

signal on_hit(other)

func _process(delta):
	if swingTimer > 0:
		swingTimer -= delta
	elif swingTimer < 0:
		stow()
		swingTimer = 0

func swing():
	$SpriteStowed.visible = false
	$SpriteHit.visible = true
	
	swingTimer = swingDuration
	$CollisionShape2D.disabled = false
	canSwing = false
	$SwingPlayer.play()

func stow():
	$SpriteStowed.visible = true
	$SpriteHit.visible = false
	$CollisionShape2D.disabled = true
	canSwing = true


func _on_Club_area_entered(area):
	emit_signal("on_hit", area)
