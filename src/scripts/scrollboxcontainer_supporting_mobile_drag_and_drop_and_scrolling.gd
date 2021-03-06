# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends ScrollContainer

# ScrollBoxContainer supporting mobile drag and drop, scrolling up and down,
# and swiping.

# Script meant to be attached to a ScrollContainer.
# Can be used in conjunction with the custom class RichTextButton to allow
# items sorting.
# Scrolling only works if any child control has "mouse_filter" set to
# "Pass" or "Ignore".

signal swipe(direction)

const SCROLL_SPEED = 4
const SWIPE_SENSITIVITY = 15

var is_dragging := false
var _scrolling_up := false
var _scrolling_down := false
var _last_scroll_vertical := 0
var _screen_has_been_touched := false


func _ready():
	var _err = connect("gui_input",self,"_on_ScrollContainer_gui_input")


func _process(_delta):
	_last_scroll_vertical = scroll_vertical
	if is_dragging:
		if _scrolling_up or _scrolling_down:
			if _scrolling_up:
				self.scroll_vertical -= SCROLL_SPEED
			else:
				self.scroll_vertical += SCROLL_SPEED
		else:
			self.scroll_vertical = _last_scroll_vertical


func _on_ScrollContainer_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_screen_has_been_touched = true
		else:
			_screen_has_been_touched = false

	if event is InputEventScreenDrag:
		if event.position.y < 100:
			_scrolling_up = true
			_scrolling_down = false
		elif event.position.y > self.rect_size.y - 100:
			_scrolling_down = true
			_scrolling_up = false
		else:
			_scrolling_up = false
			_scrolling_down = false

		if is_dragging == false and\
				_screen_has_been_touched:
			var swipe = event.relative
			if swipe.x < -SWIPE_SENSITIVITY:
				emit_signal("swipe", "left")
				_screen_has_been_touched = false # stop endless swiping
			elif swipe.x > SWIPE_SENSITIVITY:
				emit_signal("swipe", "right")
				_screen_has_been_touched = false # stop endless swiping
