extends Node

var currentEnvironment: GameEnvironment
var rateNodeA: Node
var rateNodeB: Node
var rateNodeC: Node
var globalRate: Node
var attemptsA: int
var attemptsB: int
var attemptsC: int
var successfullAttemptsA: int
var successfullAttemptsB: int
var successfullAttemptsC: int

func _ready() -> void:
	currentEnvironment = GameEnvironment.new()
	rateNodeA = get_node("../UI/LabelA")
	rateNodeA.text = "-%"
	rateNodeB = get_node("../UI/LabelB")
	rateNodeB.text = "-%"
	rateNodeC = get_node("../UI/LabelC")
	rateNodeC.text = "-%"
	globalRate = get_node("../UI/Global")
	globalRate.text = "-%"
	
func getEnvironment() -> GameEnvironment:
	var kidsNode = get_node("../Kids")
	var kids = kidsNode.kids
	currentEnvironment.setKids(kids)
	return currentEnvironment

func registerAttempt(code):
	if code == 0:
		attemptsA += 1
	elif code == 1:
		attemptsB += 1
	else:
		attemptsC += 1
	updateLabelText(code)
	
func registerSuccess(code):
	if code == 0:
		successfullAttemptsA += 1
	elif code == 1:
		successfullAttemptsB += 1
	else:
		successfullAttemptsC += 1
	updateLabelText(code)
	
func updateLabelText(code):
	var rate = float(successfullAttemptsA+successfullAttemptsB+successfullAttemptsC) / float(attemptsA+attemptsB+attemptsC)
	rate = rate * 100
	globalRate.text = str(snapped(rate, 0.01), "%")
	if code == 0:
		rate = float(successfullAttemptsA) / float(attemptsA)
		rate = rate * 100
		rateNodeA.text = str(snapped(rate, 0.01), "%")
	elif code == 1:
		rate = float(successfullAttemptsB) / float(attemptsB)
		rate = rate * 100
		rateNodeB.text = str(snapped(rate, 0.01), "%")
	else:
		rate = float(successfullAttemptsC) / float(attemptsC)
		rate = rate * 100
		rateNodeC.text = str(snapped(rate, 0.01), "%")
