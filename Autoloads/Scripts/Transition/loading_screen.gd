extends CanvasLayer

@onready var rich_text_label: RichTextLabel = $CenterContainer/VBoxContainer/HBoxContainer/RichTextLabel
@onready var progress_bar: ProgressBar = $CenterContainer/VBoxContainer/ProgressBar

var loadingTextSpeed : float = 0.4
var loadingBarSpeed : float = 2.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func play() -> void:
	show()
	loopText()
	await loadingBar()
	hide()
	
func loopText() ->void:
	var visibleChar : int = 0
	
	while true:
		rich_text_label.visible_characters = visibleChar
		while visibleChar < rich_text_label.text.length():
			visibleChar += 1
			rich_text_label.visible_characters = visibleChar
			await get_tree().create_timer(loadingTextSpeed).timeout
		visibleChar = 0

func loadingBar() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(progress_bar, "value", 100, loadingBarSpeed)
	await  tween.finished
