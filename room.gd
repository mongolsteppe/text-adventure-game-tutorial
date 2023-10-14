@tool
extends PanelContainer
class_name GameRoom

@export var room_name: String = "Room name" : set = set_room_name
@export_multiline var room_desc: String = "This is the description of the room" : set = set_room_desc

var exits: Dictionary = {}

func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text=new_name
	room_name = new_name

func set_room_desc(new_desc: String):
	$MarginContainer/Rows/RoomDescription.text=new_desc
	room_desc = new_desc

func connect_exit(direction: String, room: GameRoom):
	match direction:
		"west":
			exits[direction] = room
			room.exits["east"] = self
		"east":
			exits[direction] = room
			room.exits["west"] = self
		"north":
			exits[direction] = room
			room.exits["south"] = self
		"south":
			exits[direction] = room
			room.exits["north"] = self
		_:
			printerr("Tried to connect invalid direction: %s", direction)
