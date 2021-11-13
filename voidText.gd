extends Position2D


# Declare member variables here. Examples:
var dialogue = preload("res://typedMessage.tscn")
signal doneTyping


# Called when the node enters the scene tree for the first time.
func _ready():
	message1()
	yield(self,"doneTyping")
	queue_free()

func message1():
	var d = dialogue.instance()
	d.messages = [
		"In the beginning there were nothing.",
		"And the world was without form."#,
		#"And darkness was upon the face of the deep."
	]
	add_child(d)
	emit_signal("doneTyping")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
