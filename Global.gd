extends Node

var score = 0
signal on_score(score)

var apples = []
var applesLeft = 0
var applesInitialized = false
signal on_appleless()

var playing = false

var hitter
var catcher

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0

func addPoint():
	score += 1
	emit_signal("on_score", score)

func addApple(apple):
	apples.push_back(apple)
	applesLeft += 1
	applesInitialized = true

func removeApple():
	applesLeft -= 1
	#print("%d/%d" % [applesLeft, apples.size()])
	if applesLeft <= 0:
		emit_signal("on_appleless")
		applesInitialized = false

func resetApples():
	applesLeft = apples.size()
	for apple in apples:
		apple.reset()

func resetPeople():
	if hitter:
		hitter.reset()
	if catcher:
		catcher.reset()
