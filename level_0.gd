extends Node


# Declare member variables here. Examples:
var dialogue = preload("res://typedMessage.tscn")
signal doneTyping

# Called when the node enters the scene tree for the first time.
func _ready():
	message1()
	yield(get_tree().create_timer(10), "timeout")
	
	var voidTerminal = Dialogic.start("theVoid")
	add_child(voidTerminal)
	pass

func message1():
	var d = dialogue.instance()
	d.position.y += 512
	d.position.x += 512
	d.messages = [
		"In the beginning there were nothing.",
		"And the world was without form."#,
		#"And darkness was upon the face of the deep."
	]
	add_child(d)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_intro_length_timeout():
	get_tree().change_scene("res://level_1.tscn")
