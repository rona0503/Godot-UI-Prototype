extends Node2D

@export var length : float = 100
@export var SwipeThreshold : float =  15
var startSwipePosition : Vector2
var currentSwipePosition : Vector2
var swiping : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			startSwipePosition = event.position
		else:
			currentSwipePosition = event.position
			var delta : Vector2 = currentSwipePosition - startSwipePosition
			if delta.length() < length: 
				return
			if abs(delta.x) < abs(delta.y):
				if delta.y < 0:
					UIManager.swipe_Up_Dectected.emit(startSwipePosition, currentSwipePosition)
				else:
					UIManager.swipe_Down_Dectected.emit(startSwipePosition, currentSwipePosition)
			else:
				if delta.x < 0:
					UIManager.swipe_Left_Dectected.emit(startSwipePosition, currentSwipePosition)
				else:
					UIManager.swipe_Right_Dectected.emit(startSwipePosition, currentSwipePosition)
			
			UIManager.swipe_Dectected.emit(startSwipePosition, currentSwipePosition)
					
