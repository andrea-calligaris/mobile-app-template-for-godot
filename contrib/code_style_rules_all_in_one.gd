# This file is part of "Beautiful Game"
# Copyright 1998-1999 John Smith

tool
class_name ExampleSourceCode
extends Object

# Example source code - Demonstrating code style.

# Additional text explaining stuff in more details, using new lines like this
# and with a final dot.

const MyClass = preload("res://scripts/my_class.gd") # preload other scripts
# before anything else, like an "include" in C++


class MyClass:
	var member: float
	var other_member := 10

	func my_method():
		pass


class MyOtherClass:
	var member: int


signal event_happened

enum Things { FOO, BAR }
enum Stuff {
	FOO = 10,
	BAR = 20,
	HELLO = 30,
}

const Weapon = preload("res://Weapon.tscn")
const PATH_SCENE_ILL_LOAD_LATER = "res://TestScene.tscn"
const PATH_MY_FILE = "res://foobar.dat"
const MY_ARRAY = [1, 2, 3]
const MAX_SPEED = 200.0

export(int, 0, 10) var my_export_var := 0
export(int, -10, 20) var my_other_export_var := 0
var pos := Vector2()
var cool_node: Node = null
var float_number := 13.0
var hex_number := 0xfb8c0b
var large_number := 1_234_567_890
var _private_variable := 0
var _another_private_variable := 10
onready var cool_node := $CoolNode
onready var lbl_error_message: Label = find_node("lbl_ErrorMessage")


func _init():
	pass


func _ready():
	print_stuff(2, "Hello world")


func _unhandled_input(event: InputEvent):
	pass


func _physics_process(delta: float):
	pass


func print_stuff(n_times: int, message: String, on_screen:=true) -> bool:
#	print("using CTRL + K is very useful.")
#	print("But these lines will be uncommented or deleted before " +\
#			"deploying the code!")
	var foobar = 10
	$Node.position = Vector2(0,0) # not "get_node("Node")"
	self.add_child(new_node) # not just "add_child": using "self" makes
			#	everything clearer
	return true

func is_cool_dude(name: String) -> bool:
	if name == "Bob":
		return true
	else:
		return false


func do_something(): # this is a public method
	pass


func _do_internal_stuff(): # this is a private method
	pass


func _on_MyButton_pressed():
	var node = Control.new()
	var parent = get_tree().root
	parent.add_child(node)
	node.owner = parent # not ".set_owner(parent)"
	var long_string = "This is a long line of code" +\
			"which is getting broken and" +\
			"indented with 2 indent levels (Tabs) and with the break line '\'"
	do_beautiful_things(
			10,
			"Here instead there's no need for the break line because we're",
			"not interrupting an expression.")
	if position.x > width:
		position.x = 0
	dict["key"] = 5
	print("Prefer double quotes!")

