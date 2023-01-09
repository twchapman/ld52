extends Node


export var InstructionsContainerPath: NodePath
onready var InstructionsContainer := get_node(InstructionsContainerPath) as Control

export var GameplayContainerPath: NodePath
onready var GameplayContainer := get_node(GameplayContainerPath) as Control

export var TimerLabelPath: NodePath
onready var TimerLabel := get_node(TimerLabelPath) as Label

export var ScoreLabelPath: NodePath
onready var ScoreLabel := get_node(ScoreLabelPath) as Label

onready var Global_ = get_node("/root/Global")

var timer = 0
var gameoverBuffer = 2
var gameoverTimer = 0

func _ready():
	Global_.connect("on_score", self, "update_score")
	Global_.connect("on_appleless", self, "game_over")
	reset()
	
func reset():
	timer = 0
	#GameplayContainer.visible = false
	Global_.playing = false
	Global_.resetApples()
	Global_.resetPeople()

func start():
	Global_.score = 0
	update_score(0)
	Global_.playing = true
	#GameplayContainer.visible = true
	InstructionsContainer.visible = false

func _process(delta):	
	if Global_.playing:
		timer += delta
		var seconds = floor(timer)
		var millis = fmod(timer, 1)
		var zeroes = min(step_decimals(millis), 3)
		var millisPrinted = ""
		for z in range(zeroes - 1):
			millisPrinted += "0"
		millisPrinted += "%d" % (millis * 1000)
		if millisPrinted == "99":
			print(millis)
		TimerLabel.text = "%d:%s" % [seconds, millisPrinted]
	elif gameoverTimer > 0:
		gameoverTimer -= delta
	else:
		InstructionsContainer.visible = true

func _input(event):
	if not Global_.playing and gameoverTimer <= 0 and event is InputEventKey and event.pressed:
		start()

func update_score(score):
	ScoreLabel.text = "%d" % score

func game_over():
	reset()
	gameoverTimer = gameoverBuffer
