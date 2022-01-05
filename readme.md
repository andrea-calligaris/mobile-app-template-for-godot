# Mobile App Template for Godot

A template to start creating mobile apps (not games) with [Godot](https://godotengine.org).

<p align="center">
  <img src="preview.png" />
</p>

## Current features

* Export preset for Android.
* Fix to actually disable _immersive mode_.
* Window size and viewport settings.
* App state (previous page, page parenting, etc.).
* Swipe pages left and right.
* Scroll the screen up and down.
* Sort items.
* Gray theme adapted for mobile covering most of the _Controls_.
* Customized _SpinBox_ with bigger buttons.
* Customized _Control_ _RichTextButton_ to have buttons with wrappable and multi-colored text.
* Utility functions in [_app_manager.gd_](src/scripts/app_manager.gd).

## Understanding the template

To know what's been changed in the project settings (_project.godot_), just open the file in a text editor and the variables that will appear are the ones that have been changed.
This works for _scene files_ too, but it's easier to just browse them inside _Godot's editor_, in fact it automatically opens the menus where parameters have been changed.

## Permissions

Enable the wanted permissions in the export preset. When testing, you'll export to a debug build, therefore no permissions will be asked, and you'll have to go to your OS app settings and manually enable the permissions (those that you selected in the preset will be available to be switched on).

## Godot's bugs related to this project

* _FileDialog_ is currently non-usable; we could create a custom one, or wait for the ability to call the native file picker (see https://github.com/godotengine/godot-proposals/issues/1123.

* The _ScrollBar_ is currently a bit transparent to work around this: https://github.com/godotengine/godot/issues/56384.

## Contributing

See [contrib/](contrib/).
