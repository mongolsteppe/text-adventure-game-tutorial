extends Node

var current_room = null

func initialize(starting_room) -> String:
	return change_room(starting_room)

func process_command(input: String):
	var words = input.split(" ",false)
	if words.size() == 0:
		return "Error: no words were parsed"
		
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
		
	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "Unrecognized command - please try again."
			
			
func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	if current_room.exits.keys().has(second_word):
		var change_response = change_room(current_room.exits[second_word])	
		return "\n".join(PackedStringArray([ "You go %s" % second_word, change_response]))
	else:
		return "This room has no exit in that direction."
	
func help() -> String:
	return "You can use these commands: go [orientation], help"
	
func change_room(new_room: GameRoom):
	current_room=new_room
	var exit_string = "\n".join(PackedStringArray(new_room.exits.keys()))
	var strings = "\n".join(PackedStringArray([
		"You are now in "+new_room.room_name + ". It is " + new_room.room_desc,
		"Exits: " + exit_string
	]))
	return strings
