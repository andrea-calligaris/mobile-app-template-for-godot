# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends Node

# App manager - The global script, autoloaded as "AM".

# Manages all behind-the-scene objects, the actual data of your app; the various
# pages of the app refers to this script to load and save user data.
# There are various utility functions here that may be of help, that you can
# call from any of the pages.

var _main_scene: Control = null
var pages_container: Control = null
var nice_foods := []


class TFood:
	var name := ""
	var favorite := false


func _ready():
	# initialize foods:
	var food: TFood
	food = TFood.new()
	food.name = "Pizza"
	food.favorite = true
	nice_foods.append(food)

	food = TFood.new()
	food.name = "French fries"
	food.favorite = true
	nice_foods.append(food)

	food = TFood.new()
	food.name = "Fried calamari"
	nice_foods.append(food)

	food = TFood.new()
	food.name = "Tiramisu"
	nice_foods.append(food)

	for counter in range(5,15):
		food = TFood.new()
		food.name = "Food #" + str(counter)
		nice_foods.append(food)


func dprint(string: String, variable): # print a variable name and content
	print(string+": "+var2str(variable))


func get_children_recursive(node: Control, nodes: Array):
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			get_children_recursive(N, nodes)
		else:
			nodes.append(N)


func show_confirmation_dialog(caller: Control, title: String, text: String,
		method_accept: String):
	var dialog = ConfirmationDialog.new()
	dialog.theme = preload("res://themes/theme.tres")
	dialog.get_close_button().queue_free()
	dialog.dialog_autowrap = true
	dialog.grow_vertical = Control.GROW_DIRECTION_BEGIN
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.set_exclusive(true)
	dialog.connect('confirmed', caller, method_accept)
	caller.add_child(dialog)
	dialog.popup_centered()


func switch_top_level_page(page_name: String):
	_main_scene.switch_top_level_page(page_name)


func get_html_color(color: Color) -> String:
	return "#" + color.to_html(false)


func go_back(page, previous_page):
	# manages going back from one page to the previous
	if previous_page == null:
		return
	if page.visible == false:
		return

	previous_page.visible = true
	page.queue_free()


func is_OS_Android() -> bool:
	if OS.get_name() != "Windows" and OS.get_name() != "X11":
		return true
	else:
		return false


func get_external_data_dir() -> String:
	# return the external storage folder.
	# Must be done manually because right now there is no Godot's function
	# for this.
	# Actually reading and writing on external storage only works if in
	# the export preset you check the permissions "Read External Storage" and
	# "Write External Storage".
	# This is useful e.g. to export and import user data.
	# You'll do this via a FileDialog, which is currently bugged and bad in
	# general for mobile. If you create a customized FileDialog feel free to
	# contribute.
	if is_OS_Android():
		return "/storage/emulated/0/"
	else:
		return OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/"


func get_top_level_page() -> Node:
	return pages_container.get_child(0)
