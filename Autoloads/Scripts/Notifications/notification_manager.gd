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
					await popDown(notificationInstance, notificationInstance.PanelPosition)
				"Bottom_Left", "Bottom_Middle", "Bottom_Right":
					await popUp(notificationInstance, notificationInstance.Panel_Position)
		"Horizontal":
			match position:
				"Top_Left", "Center_Left", "Bottom_Left":
					await popRight(notificationInstance, notificationInstance.PanelPosition)
				"Top_Right", "Center_Right", "Bottom_Right":
					await popLeft(notificationInstance, notificationInstance.PanelPosition)
		
func popRight(notificationInstance : Control, finalPosition : Vector2) -> void:
	var tween : Tween = create_tween()
	notificationInstance.Notification_container.position.x -= notificationInstance.PanelSize.x
	var endPosition : float = notificationInstance.Notification_container.position.x
	tween.tween_property(notificationInstance.Notification_container, "position:x", finalPosition.x, duration)
	await tween.finished
	
	await get_tree().create_timer(duration).timeout
	
	var tween2 : Tween = create_tween()
	tween2.tween_property(notificationInstance.Notification_container, "position:x", endPosition, duration)
	await tween2.finished
	notificationInstance.queue_free()

func popLeft(notificationInstance : Control, finalPosition : Vector2) -> void:
	var tween : Tween = create_tween()
	notificationInstance.Notification_container.position.x += notificationInstance.PanelSize.x
	var endPosition : float = notificationInstance.Notification_container.position.x
	tween.tween_property(notificationInstance.Notification_container, "position:x", finalPosition.x, duration)
	await  tween.finished
	
	await get_tree().create_timer(duration).timeout
	
	var tween2 : Tween = create_tween()
	tween2.tween_property(notificationInstance.Notification_container, "position:x", endPosition, duration)
	await tween2.finished
	notificationInstance.queue_free()

func popDown(notificationInstance : Control, finalPosition : Vector2) -> void:
	var tween : Tween = create_tween()
	notificationInstance.Notification_container.position.y -= notificationInstance.PanelSize.y
	var endPosition : float = notificationInstance.Notification_container.position.y
	tween.tween_property(notificationInstance.Notification_container, "position:y", finalPosition.y, duration)
	await  tween.finished
	
	await get_tree().create_timer(duration).timeout
	
	var tween2 : Tween = create_tween()
	tween2.tween_property(notificationInstance.Notification_container, "position:y", endPosition, duration)
	await tween2.finished
	notificationInstance.queue_free()
	
func popUp(notificationInstance : Control, finalPosition : Vector2) -> void:
	var tween : Tween = create_tween()
	notificationInstance.Notification_container.position.y += notificationInstance.PanelSize.y
	var endPosition : float = notificationInstance.Notification_container.position.y
	tween.tween_property(notificationInstance.Notification_container, "position:y", finalPosition.y, duration)
	await  tween.finished
	
	await get_tree().create_timer(duration).timeout
	
	var tween2 : Tween = create_tween()
	tween2.tween_property(notificationInstance.Notification_container, "position:y", endPosition, duration)
	await tween2.finished
	notificationInstance.queue_free()
