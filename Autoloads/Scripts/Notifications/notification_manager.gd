@tool
extends CanvasLayer

var NotificationScene : PackedScene = preload("res://Autoloads/Scenes/Notifications/notification.tscn")
var duration : float = 1.5
var NotificationQueue : Array
var busy : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.connect("add_default_notification",setup_notification)
	UIManager.connect("add_notification", setup_notification)

func setup_notification(title : String, message : String, position : String = "Top_Right", PopUpStyle : String = "Vertical") ->void:	
	var NotificationInstance : Control = NotificationScene.instantiate()
	
	call_deferred("add_child", NotificationInstance)
	await NotificationInstance.ready
	NotificationInstance.set_notification(title, message)
	NotificationInstance.set_message_initial_position(position)
	NotificationInstance.hide()
	NotificationQueue.append([NotificationInstance, position, PopUpStyle])

	processNotificationQueue()

func processNotificationQueue() -> void:
	if NotificationQueue.is_empty() or busy:
		return
	
	busy = true
	var NotifData : Array = NotificationQueue.pop_front()
	var NotificationInstance : Control = NotifData[0]
	NotificationInstance.show()
	var Position : String = NotifData[1]
	var PopUpStyle : String = NotifData[2]
	
	await play(NotificationInstance, Position, PopUpStyle)
	busy = false
	processNotificationQueue()
	
func play(notificationInstance : Control, position : String, PopUpStyle : String) -> void:
	match PopUpStyle:
		"Vertical":
			match position:
				"Top_Left", "Top_Middle", "Top_Right":
					#await popDown(notificationInstance, notificationInstance.PanelPosition)
					await  popNotification(notificationInstance,PopUpStyle, Vector2(0,-notificationInstance.PanelSize.y))
				"Bottom_Left", "Bottom_Middle", "Bottom_Right":
					await  popNotification(notificationInstance,PopUpStyle, Vector2(0,notificationInstance.PanelSize.y))
		"Horizontal":
			match position:
				"Top_Left", "Center_Left", "Bottom_Left":
					await  popNotification(notificationInstance,PopUpStyle, Vector2(-notificationInstance.PanelSize.x,0))
				"Top_Right", "Center_Right", "Bottom_Right":
					await  popNotification(notificationInstance,PopUpStyle, Vector2(notificationInstance.PanelSize.x,0))

func popNotification(notificationInstance : Control, popUpStyle : String, initialPosition : Vector2) -> void:
	
	var tween : Tween = create_tween()
	var position : String = "x" if popUpStyle == "Horizontal" else "y"
	var finalPosition : float = notificationInstance.PanelPosition.x if position == "x" else notificationInstance.PanelPosition.y
	notificationInstance.Notification_container.position += initialPosition
	var endPosition : float = notificationInstance.Notification_container.position.x if position == "x" else notificationInstance.Notification_container.position.y
	
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(notificationInstance.Notification_container, "position:" + position, finalPosition, duration)
	await tween.finished
	
	await get_tree().create_timer(duration / 2).timeout
	tween.kill()
	tween = create_tween()
	
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(notificationInstance.Notification_container, "position:" + position, endPosition, duration)
	await tween.finished
	
	notificationInstance.queue_free()
