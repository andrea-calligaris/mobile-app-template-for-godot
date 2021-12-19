# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends PanelContainer

# Child page - A page that is a child of another page.

var _caller: Control = null


func initialize(caller: Control):
	self._caller = caller


func _notification(what): # to go back on mobile with the back button
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or\
			what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		AM.go_back(self, _caller)


func _input(event): # to go back while testing on PC
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		AM.go_back(self, _caller)


func _on_btn_Cancel_pressed():
	AM.go_back(self, _caller)


func _on_ScrollContainer_swipe(direction):
	if direction == "right":
		AM.go_back(self, _caller)
