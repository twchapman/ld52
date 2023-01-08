extends Node

export var TimerLabelPath: NodePath
onready var TimerLabel := get_node(TimerLabelPath) as Label

var timer = 0

func _ready():
	timer = 0

func _process(delta):
	timer += delta
	var seconds = floor(timer)
	var millis = fmod(timer, 1)
	var zeroes = min(step_decimals(millis), 3)
	var millisPrinted = ""
	for z in range(zeroes - 1):
		millisPrinted += "0"
	millisPrinted += "%d" % (millis * 1000)
	#print("%s:%d" % [millisPrinted, zeroes])
	if millisPrinted == "99":
		print(millis)
	TimerLabel.text = "%d:%s" % [seconds, millisPrinted]
