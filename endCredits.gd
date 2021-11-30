extends Node

const section_time := 2
const line_time := 0.8
const base_speed := 32
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $creditsContainer/line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"The End of this Demo"
	],[
		"About",
		"You have been playing 'The Ultimate Bug' concept demo.",
		"Created for the 'Game Off 2021' gaming jam at itch.io",
		"",
		"This was my first ever attempt at designing a full game.",
		"I didn't have time to finish it for the gaming jam deadline.",
		"",
		"But this was fun and I like the artstyle I have put together.",
		"There's a story written and I'm likely to finish the full game.",
		"If you want updates follow the game over at:",
		"",
		"https://victorieeman.itch.io/the-ultimate-bug-2021"
	],[
		"Programming & Game Design",
		"VictorieeMan"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Artwork and game resources:",
		"Created by Myself or borrowed stuff from the following sites",
		"https://freesvg.org",
		"https://gamesounds.xyz",
		"https://fonts.google.com",
		"https://pixabay.com",
		"https://publicdomainvectors.org",
		"https://github.com",
		"",
		"Publicdomain and or Non-attribution requiered resources",
		"but more detailed references are available in the @Reference.txt file"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene("res://menu.tscn")
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$creditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
