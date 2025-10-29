extends CanvasLayer

@export var NotificationPanel : PackedScene

func add_notification(title : String, message : String, location : int, popStyle : String, duration : float = 1.5) ->void:
	var NotifInstance : Control = NotificationPanel.instantiate()
	NotifInstance.set_anchors_preset(location)
	
	add_child(NotifInstance)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
