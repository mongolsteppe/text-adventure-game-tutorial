extends Node

const InputResponse = preload("res://input_response.tscn")
const Response = preload("res://branches/response.tscn")

#@export var max_lines_remembered := 3
@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/ScrollContainer
@onready var command_processor = $CommandProcessor
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var room_manager = $RoomManager

func _ready() -> void:
	handle_response_generated("Welcome to the game. If you need guidance, type 'help'")
	scrollbar.changed.connect(handle_scrollbar_changed)
	command_processor.response_generated.connect(handle_response_generated)
	command_processor.initialize(room_manager.get_child(0))

func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value

func _on_input_text_submitted(new_text: String) -> void:
	if(new_text != ""):
		var input_response = InputResponse.instantiate()
		var response = command_processor.process_command(new_text)
		input_response.set_text(new_text, response)
		history_rows.add_child(input_response)

func handle_response_generated(response_text: String):
	var response = Response.instantiate()
	response.text = response_text #"Welcome to the game blablabla"
	add_response_to_game(response)

func add_response_to_game(response: Control):
	history_rows.add_child(response)
#	delete_history_beyond_limit()

# Limit how many lines past history displays (and when you reach max, then delete the first)
#	if history_rows.get_child_count() > max_lines_remembered:
#		history_rows.get_child(0).queue_free()
