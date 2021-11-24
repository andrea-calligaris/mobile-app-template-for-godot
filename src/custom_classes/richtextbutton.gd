# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

class_name RichTextButton
extends MarginContainer

# RichTextButton class - A container with a Button and a RichTextLabel.

# This allows to have multi-colored wrappable text; it also supports internal
# margins and it has drag and drops functionalities to allow the user to sort
# items.

signal pressed

const StyleBoxButtonHeldDown =\
		preload("res://themes/stylebox_button_held_down.tres")

const A_BIT_OF_LEFT_INTERNAL_MARGIN = 20

export(bool) var toggle_mode := false
export(Font) var font: Font = null
var _main_page = null
var _scroll_container = null
var _item = null
var _draggable = false
var _is_dragging = false
var _timer_is_running = false
onready var button: Button = find_node("Button")
onready var margin_container: MarginContainer = find_node("MarginContainer")
onready var label: RichTextLabel = find_node("RichTextLabel")
onready var timer_to_start_dragging = find_node("TimerToStartDragging")


func _ready():
	if toggle_mode:
		button.toggle_mode = true
	if Font != null:
		label.set("custom_fonts/normal_font",font)
	_on_RichTextLabel_resized()


func set_pressed(pressed: bool):
	button.pressed = pressed


func _on_Button_pressed():
	emit_signal("pressed")


func set_bbcode_text(text: String):
	label.bbcode_text = text


func set_internal_margins(t: float, l: float, b: float, r: float):
	var it = int(t)
	var il = int(l)
	var ib = int(b)
	var ir = int(r)
	margin_container.add_constant_override("margin_top", it)
	margin_container.add_constant_override("margin_left", il)
	margin_container.add_constant_override("margin_bottom", ib)
	margin_container.add_constant_override("margin_right", ir)


func set_draggable(main_page: Control, scroll_container: ScrollContainer, item):
	self._main_page = main_page
	self._scroll_container = scroll_container
	self._item = item
	_draggable = true


func get_drag_data(_pos):
	# Godot's virtual function.
	# You just started dragging an object of this class;
	# retrieve info about what you're dragging.
	if _is_dragging == false:
		return null

	# create the preview, that is the semi-transparent object that
	# you are dragging:
	var rtb = self.duplicate()
	var host_control = Control.new()
	host_control.add_child(rtb)
	rtb.rect_position = -0.5 * rtb.rect_size # center it
	set_drag_preview(host_control)
	return _item


func can_drop_data(_pos, dragged_item) -> bool:
	# Godot's virtual function.
	# Something is being dragged over an object of this class;
	# check if this "something" can actually drop over here or not.
	# Basically the opposite of the previous function: we are the
	# receiver here.
	if _draggable == false:
		return false
	elif dragged_item == _item:
		return false
	return true


func drop_data(_pos, dragged_item):
	# Godot's virtual function.
	# Looks like the dragged item can be dropped over here.
	# Let's therefore call the page where all this is happening
	# and tell it that an item has been dragged & dropped over
	# another; then the page will do what it wants, e.g.
	# sort those items.
	if _draggable == false:
		return

	_main_page._on_item_dragged_and_dropped(dragged_item, self._item)


func _set_is_dragging(val: bool):
	if val == true:
		_timer_is_running = false
		_is_dragging = true
		_scroll_container.is_dragging = true
		button.add_stylebox_override("focus",StyleBoxButtonHeldDown)
		button.add_stylebox_override("pressed",StyleBoxButtonHeldDown)
		button.add_stylebox_override("normal",StyleBoxButtonHeldDown)
	else:
		_is_dragging = false
		_scroll_container.is_dragging = false
		button.add_stylebox_override("focus",null)
		button.add_stylebox_override("pressed",null)
		button.add_stylebox_override("normal",null)


func _delayed_on_RichTextLabel_resized():
	button.set_size(self.rect_size)


func _on_RichTextLabel_resized():
	call_deferred("_delayed_on_RichTextLabel_resized")


func _on_Button_gui_input(event):
	if _draggable == false:
		return

	if event is InputEventScreenTouch:
		if event.pressed:
			timer_to_start_dragging.start()
			_timer_is_running = true
		else:
			timer_to_start_dragging.stop()
			_set_is_dragging(false)
	elif event is InputEventScreenDrag:
		if _timer_is_running:
			timer_to_start_dragging.stop()


func _on_TimerToStartDragging_timeout():
	_set_is_dragging(true)
