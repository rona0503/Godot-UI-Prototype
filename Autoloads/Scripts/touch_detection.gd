extends Node2D

@export var length : float = 100
@export var SwipeThreshold : float =  15
@export var LongTouchSecondsThreshold : float = 5.0
var startTouchPosition : Vector2
var currentTouchPosition : Vector2
var currentTime : float
var touchHeld : bool
var swiping : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			startTouchPosition = event.position
			touchHeld = true
		else:
			touchHeld = false
			##Swipe Detection
			currentTouchPosition = event.position
			var delta : Vector2 = currentTouchPosition - startTouchPosition
			if delta.length() < length: 
				return
			else:
				if abs(delta.x) < abs(delta.y):
					if delta.y < 0:
						UIManager.swipe_Up_Dectected.emit(startTouchPosition, currentTouchPosition)
					else:
						UIManager.swipe_Down_Dectected.emit(startTouchPosition, currentTouchPosition)
				else:
					if delta.x < 0:
						UIManager.swipe_Left_Dectected.emit(startTouchPosition, currentTouchPosition)
					else:
						UIManager.swipe_Right_Dectected.emit(startTouchPosition, currentTouchPosition)
				
				UIManager.swipe_Dectected.emit(startTouchPosition, currentTouchPosition)
				
			
func _process(delta: float) -> void:
	if touchHeld:
		currentTime += delta
		if currentTime >= LongTouchSecondsThreshold:
				UIManager.long_Touch_Detected.emit(startTouchPosition, currentTouchPosition)
				touchHeld = false
				currentTime = 0
