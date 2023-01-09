extends Node2D

var lifetime = 0.5

func _process(delta):
	if lifetime <= 0:
		queue_free()
	lifetime -= delta
	position.y -= delta * 10
