extends LineEdit


func _ready() -> void:
	grab_focus()


func _process(_delta: float) -> void:
	pass



func _on_text_submitted(_new_text: String) -> void:
	clear()
