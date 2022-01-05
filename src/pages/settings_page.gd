# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends PanelContainer

# Settings page - Also shows the app's credits.

enum PageTypes { SETTINGS, CREDITS }

const SCENE_PATH_SETTINGS_PAGE = "res://pages/SettingsPage.tscn"
const CREDITS_BBCODE =\
"""[color=black][b]Font[/b]
Inconsolata, under SIL Open Font License, Version 1.1.
Proxima Nova Condensed, free for personal and commercial use.

[b]App's icon[/b]
Made by Andrea Calligaris in 2021
([url]https://github.com/andrea-calligaris[/url])
Licensed under the [url=http://www.wtfpl.net/txt/copying/]WTFPL[/url].

[b]Home icon[/b]
SimpleIcon ([url]http://www.simpleicon.com[/url])
License: [url=https://creativecommons.org/licenses/by/3.0]CC BY 3.0[/url].
downloaded via [url=https://commons.wikimedia.org/wiki/File:Simpleicons_Places_home-outline-with-black-door-and-roof.svg]Wikimedia Commons[/url].

[b]Settings icon[/b]
[url]https://freeiconshop.com/icon/settings-icon-outline-2/[/url].
License: [url]https://freeiconshop.com/icon-shop-license/[/url].
[/color]
"""

var _caller: Control = null
var _page = PageTypes.SETTINGS
onready var lbl_page_title = find_node("lbl_PageTitle")
onready var container_settings = find_node("ContainerSettings")
onready var btn_delicate_action = find_node("btn_DelicateAction")
onready var container_credits = find_node("ContainerCredits")
onready var rtl_credits = find_node("rtl_Credits")

func initialize_as_settings_page():
	_page = PageTypes.SETTINGS
	container_settings.visible = true
	container_credits.visible = false

func initialize_as_credits_page(caller: Control):
	self._caller = caller
	_page = PageTypes.CREDITS
	container_settings.visible = false
	container_credits.visible = true
	lbl_page_title.text = "Credits"
	rtl_credits.bbcode_text = CREDITS_BBCODE


func _notification(what): # to go back on mobile with the back button
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or\
			what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		AM.go_back(self, _caller)


func _input(event): # to go back while testing on PC
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		AM.go_back(self, _caller)


func _on_confirm_delicate_action():
	btn_delicate_action.text = "Nah, I won't do it."
	btn_delicate_action.disabled = true


func _on_btn_Credits_pressed():
	# instance another one of this same scene, but initialize it as
	# the credit page:
	var scene = load(SCENE_PATH_SETTINGS_PAGE).instance()
	AM.pages_container.add_child(scene)
	scene.initialize_as_credits_page(self)


func _on_rtl_Credits_meta_clicked(url):
	var _err = OS.shell_open(url)


func _on_btn_DelicateAction_pressed():
	AM.show_confirmation_dialog(self, "Deleting the universe", "Are you sure?",
		"_on_confirm_delicate_action")
