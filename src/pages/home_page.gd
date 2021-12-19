# This file is part of "Mobile App Template for Godot"
# Copyright (c) 2021 Andrea Calligaris
# Distributed under the MIT software license, see LICENSE.txt

extends PanelContainer

# Home page.

const RichTextButtonScene = preload("res://custom_classes/RichTextButton.tscn")
const ChildPage = preload("res://pages/ChildPage.tscn")

onready var container_list = find_node("ContainerList")
onready var scroll_container = find_node("ScrollContainer")


func _ready():
	update_page()


func update_page():
	# clear the list:
	for child in container_list.get_children():
		child.queue_free()

	# print a list of all foods:
	for food in AM.nice_foods:
		var richtextbutton = RichTextButtonScene.instance()
		container_list.add_child(richtextbutton)
		richtextbutton.set_internal_margins(10,0,10,0)
		var txt = "[center]" + food.name + "[/center]"
		if food.favorite:
			txt = "[color=" + AM.get_html_color(Color.darkslateblue) +\
					"][b]" + txt + "[/b][/color]"
		else:
			txt = "[color=black]" + txt + "[/color]"
		richtextbutton.set_bbcode_text(txt)
		richtextbutton.connect("pressed", self,
				"_on_btn_ItemPressed", [food])
		richtextbutton.set_draggable(self, scroll_container, food)


func _on_btn_ItemPressed(item):
	print("You clicked on " + item.name)


func _on_item_dragged_and_dropped(dragged_item, landing_item):
	var dragged_food_idx = AM.nice_foods.find(dragged_item)
	AM.nice_foods.remove(dragged_food_idx)
	var landing_food_idx = AM.nice_foods.find(landing_item)
	AM.nice_foods.insert(landing_food_idx, dragged_item)
	update_page()


func _on_btn_GotoChildPage_pressed():
	var scene = ChildPage.instance()
	AM.pages_container.add_child(scene)
	scene.initialize(self)


func _on_ScrollContainer_swipe(direction):
	if direction == "left":
		_on_btn_GotoChildPage_pressed()
