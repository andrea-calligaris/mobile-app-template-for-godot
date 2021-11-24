# Contributing

## Code style

You have to follow Godot's [GDScript Style Guide](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_styleguide.html).

In addition, you have to follow the guidelines described below. You can see them all in action in the example [code_style_rules_all_in_one.gd](code_style_rules_all_in_one.gd).

### Suggested editor settings

See [Suggested settings for Godot's editor](suggested_editor_settings.md)

### Godot's bugs

Until the infamous cyclic reference errors don't get fixed in 4.0, just keep all main classes in a single script file. To easily navigate such file, immediately before any class just do:

`static func TClassName():pass`

so you can navigate to the given class by the window on the bottom left of the script editor.
There will be no name conflicts for some reason.
This will allow e.g. to do static typing of classes without getting those annoying errors.

### Reasonably clean code

* Try to extract whenever a function becomes too long, not at *Robert Martin*'s madness level, but at a reasonable compromise. If a class contains an adjective derived from a verb like "saver", you probably shouldn't have extracted that class and should have just made a function, unless that function is very long and not much sequential.

  A function of circa 15 lines of code with two nested if-else is perfectly fine and extracting it may make it less readable.

* Use comments only to make sequential code clearer or to separate it into sections; don't comment obvious stuff. If you need to explain verbosely some concept just write documentation for the developers in a separate *.md* file.
If there are way too many comments just extract into private functions.

* For functions and methods use maximum three arguments, preferably two. Never pass booleans unless for things like `set_enabled(true)` because you never know what they stand for and so they make reading the code more annoying.

### Filenames

* *MyScene.tscn*
* *my_script.gd*
* *cool_resource.png*
* *theme_panel.tres*

### Names of control nodes

* btn_ClickHere
* ck_CoolCheckBox
* opt_MyOptionButton

etc.; check the project itself for other abbreviations.

In code:

`onready var lbl_error_message: Label = find_node("lbl_ErrorMessage")`

Static typed control nodes are useful for example to prevent bugs like writing


`lbl_error_message = "Error!"`
in place of

`lbl_error_message.text = "Error!"`

If a control node is not referenced in the scripts, don't bother changing its name (e.g. "Label3" can stay like that).

### General guidelines

Always use static typing when initializing the class/script's members. Constants are excluded.

Don't use Godot's `setget` methods when Godot allows to change that one particular member directly.

Always `preload()` important resources in a constant. For less important resources (that you're not going to immediately need) use a constant containing the path of the resource and than `load()` it when needed.

Sometimes using the keyword `self` can be very useful. Methods like `add_child()`, called directly, can be confusing because we don't immediately realize who's supposed to be the parent. The keyword "self" forces the reader to think about who's actually calling that method.

Don't use the *word wrap* feature of the editor. Respect the line length guideline and use the break line feature (`\`).

You can use a new line (no more than one) to separate logical sections; however, it may be better to separate the code in more functions.

No more than one newline at the end of the file.

Make use of the `$` shortcut in place of `get_node()` where possible; if you do this every frame though, or you do it multiple times inside the same function, load the node at the start of the source code with `onready var`.

`update()` is an internal function for nodes that redraws them. So, never create a function of your own with that name; but call it e.g. `update_position`.

### Sections of the GDScript source file

Sections are separated by a new line (two for functions, otherwise no more than one), and should follow this ordering:
* Copyright notice
* `tool` keyword, `class_name`, `extends` instruction
* Brief description of the script, in the form of: `# Name of the script - Description`
* Long description of the script if really necessary
* Preloading of other scripts, like an *include* in C++
* Classes declarations
* Signals
* Enums
* Constants, in this order:
  * Preloading of resources, using `const` and `preload()`
  * Paths of resources
  * Other constants
* Variables, in this order:
  * Exported variables
  * Public variables
  * Private variables (`_`)
  * `onready` variables
* Optional built-in virtual `_init` method
* Optional built-in virtual `_ready` method
* Remaining built-in virtual methods
* Public methods
* Private methods
* Private callback methods (things like `on_Button_pressed`)
