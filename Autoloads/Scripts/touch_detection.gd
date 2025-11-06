extends Node2D

@export var length : float = 100
@export var Threshold : float =  15
@export var LongTouchSecondsThreshold : float = 5.0
var startTouchPosition : Vector2
var currentTouchPosition : Vector2
var swiping : bool = false
var deltaLength : Vector2

var currentTime : float
var touchHeld : bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Press"):
		if !touchHeld:
			touchHeld = true
			swiping = false
		startTouchPosition = get_global_mouse_position()
		
			
	if Input.is_action_pressed("Press"):
		currentTime += delta
		currentTouchPosition = get_global_mouse_position()
		deltaLength = currentTouchPosition - startTouchPosition
		
		if touchHeld:
			if startTouchPosition.distance_to(currentTouchPosition) >= Threshold:
				touchHeld = false
				swiping = true
			
		if swiping:
			if startTouchPosition.distance_to(currentTouchPosition)>= length:
				if abs(deltaLength.x) <= Threshold:
					if deltaLength.y < 0:
						UIManager.swipe_Up_Dectected.emit(startTouchPosition, currentTouchPosition)
						swiping = false
					else:
						UIManager.swipe_Down_Dectected.emit(startTouchPosition, currentTouchPosition)
						swiping = false
					swiping = false
				if abs(deltaLength.y) <= Threshold:
					if deltaLength.x < 0:
						UIManager.swipe_Left_Dectected.emit(startTouchPosition, currentTouchPosition)
						swiping = false
					else:
						UIManager.swipe_Right_Dectected.emit(startTouchPosition, currentTouchPosition)
						swiping = false
					swiping = false
			currentTime = 0
		if touchHeld and !swiping:
			if currentTime >= LongTouchSecondsThreshold:
				if currentTime < LongTouchSecondsThreshold + .2:
					UIManager.long_Touch_Detected.emit(startTouchPosition, currentTouchPosition)
					currentTime = 0
					touchHeld = false
				else:
					currentTime = 0
					touchHeld = false
	else:
		touchHeld = false
		swiping = false
