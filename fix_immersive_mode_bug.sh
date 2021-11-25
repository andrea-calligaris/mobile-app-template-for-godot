#!/bin/bash
# Fix immersive mode bug

# This script changes the "themes.xml" file in order to fix a bug in Godot 3.3.2 where even when checking "Immersive Mode" when exporting, the status bar is not visible on most phones.
# First install the Android build template from Godot's editor, then run this script.

cp -f themes.xml src/android/build/res/values/

