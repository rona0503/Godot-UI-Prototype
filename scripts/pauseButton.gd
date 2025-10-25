extends Button

var activeMenus : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.menuClosed.connect(_on_menuClosed)
	UIManager.menuOpened.connect(_on_menuOpened)


func _on_button_up() -> void:
	hide()
	get_tree().paused = true
	UIManager.openMenu(UIManager.Menu.PAUSE_MENU)

func _on_menuOpened(menu : int) -> void:
	activeMenus[menu] = true
	hide()

func _on_menuClosed(menu : int) -> void:
	activeMenus.erase(menu)
	if activeMenus.is_empty():
		show()
		get_tree().paused = false
