extends CanvasLayer

@export var NotificationPanel : PackedScene

var CurrewntNotifs : Array[Control]
func add_notification(title : String, message : String, location : int = Control.PRESET_TOP_RIGHT, popStyle : String = "Vertical", duration : float = 1.5) ->void:
	
	var NotifInstance : Control = NotificationPanel.instantiate()
	add_child(NotifInstance)
	
	NotifInstance.set_message_anchor(location)
	NotifInstance.set_notification(title, message)
	await get_tree().process_frame
	print(NotifInstance.PanelSize, "1")
	CurrewntNotifs.append(NotifInstance)
	proccessNotif(popStyle, duration)

func proccessNotif(popStyle : String, duration: float) -> void:
	if CurrewntNotifs.is_empty():
		return
	var notifs :Control = CurrewntNotifs.pop_front()
	if popStyle == "Vertical":
		if notifs.position.y == 0:
			print("1")
			print(notifs.position.y," ",notifs.PanelSize.y)
			notifs.position.y -= notifs.PanelSize.y
			print(notifs.position.y," ",notifs.PanelSize.y)
			play(notifs, "y", 0,notifs.position.y, duration)
		else:
			print("2")
			var oldYPosition : float = notifs.position.y
			notifs.position.y += notifs.PanelSize.y
			play(notifs, "y", oldYPosition,notifs.position.y, duration)
	elif popStyle == "Horizontal":
		if notifs.position.x == 0:
			notifs.position.x -= notifs.PanelSize.x
			play(notifs, "x", 0,notifs.position.x ,duration)	
		else:
			var oldXPosition : float = notifs.position.x
			notifs.position.x += notifs.PanelSize.x
			play(notifs,  "x", oldXPosition,notifs.position.x, duration)
	proccessNotif(popStyle, duration)
		
			
				
func play(notif : Control,axis : String, pos : float,  final : float, duration : float) -> void:
	var tween : Tween = create_tween()
	
	print(pos, final, duration, axis)
	
	tween.tween_property(notif,"position:" + axis, pos, duration)
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	var tween2: Tween = create_tween()
	tween2.tween_property(notif, "position:" + axis, final, duration - 1)
	await  tween2.finished
	notif.queue_free()
	
	
func _ready() -> void:
	UIManager.connect("addDefaultNotifs", add_notification)
	UIManager.connect("addNotifs", add_notification)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
