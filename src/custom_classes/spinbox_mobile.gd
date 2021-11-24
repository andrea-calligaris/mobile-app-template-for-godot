# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends HBoxContainer

# Spinbox mobile - SpinBox with bigger buttons for better use on mobile.

export(int) var value := 1
export(int) var min_value := 0
export(int) var max_value := 300
export(int, 1, 100) var step := 1
var enabled := true
onready var lineedit: LineEdit = find_node("le_Value")
onready var btn_decrease: Button = find_node("btn_Decrease")
onready var btn_increase: Button = find_node("btn_Increase")


func _ready():
	update_spinbox()


func set_value(val: int):
	value = val
	update_spinbox()


func switch_enabled():
	enabled = !enabled
	if enabled == false:
		lineedit.editable = false
		btn_decrease.disabled = true
		btn_increase.disabled = true
	else:
		lineedit.editable = true
		update_spinbox()


func is_enabled() -> bool:
	return enabled


func update_spinbox():
	value = int( min(max(value,min_value),max_value) )
	if value == min_value:
		btn_decrease.disabled = true
	else:
		btn_decrease.disabled = false
	if value == max_value:
		btn_increase.disabled = true
	else:
		btn_increase.disabled = false
	lineedit.text = str(value)


func _on_btn_Decrease_pressed():
	value -= step
	update_spinbox()


func _on_btn_Increase_pressed():
	value += step
	update_spinbox()


func _on_le_Value_text_entered(new_text):
	value = int(new_text)
	update_spinbox()


func _on_le_Value_focus_exited():
	value = int(lineedit.text)
	update_spinbox()
