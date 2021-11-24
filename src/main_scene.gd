# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends Control

# Main scene - Main panel of the app.

# It has the navigation buttons at the bottom and is ready to load and show the
# various pages of the app.

const HomePage = preload("pages/HomePage.tscn")
const SettingsPage = preload("pages/SettingsPage.tscn")

onready var pages_container: Control = find_node("PagesContainer")
onready var btn_goto_home: Button = find_node("btn_GotoHome")
onready var btn_goto_settings: Button = find_node("btn_GotoSettings")

func _ready():
	AM._main_scene = self
	AM.pages_container = pages_container

	switch_top_level_page("home")


func switch_top_level_page(page_name: String):
	if page_name == "home":
		_on_btn_GotoHome_pressed()
	elif page_name == "settings":
		_on_btn_GotoSettings_pressed()


func _clear_all_pages():
	for child in AM.pages_container.get_children():
		child.queue_free()


func _release_all_goto_buttons():
	btn_goto_home.pressed = false
	btn_goto_settings.pressed = false


func _on_btn_GotoHome_pressed():
	_release_all_goto_buttons()
	btn_goto_home.set_pressed(true)
	_clear_all_pages()
	AM.pages_container.add_child(HomePage.instance())


func _on_btn_GotoSettings_pressed():
	_release_all_goto_buttons()
	btn_goto_settings.pressed = true
	_clear_all_pages()
	var scene = SettingsPage.instance()
	AM.pages_container.add_child(scene)
	scene.initialize_as_settings_page()
