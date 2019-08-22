// fix width -- done!
// fix buttons
// measure up QuNeo
// refer to SCLOrkSynths
// match up Composite View dimensions with window dimensions
// build smaller Composite Buttons
// don't hardcode dimensions, use variables!
(
var window, composite, left, right, vader, slider; // must happen first
Window.closeAll;
window = Window.new(name: "QuNeo", bounds: Rect(275, 163, 900, 600), resizable: false).front;
composite = CompositeView(parent: window, bounds: Rect(25, 25, 850, 550));
composite.background = Color.black;


// want it above
// left side
// using compositeviews instead of flowlayouts
left = CompositeView(parent: composite, bounds: Rect(10, 10, 250, 270));
left.background = Color.new255(127, 255, 212); // aquamarine

// 16 buttons
right = CompositeView(parent: composite, bounds: Rect(260, 10, 580, 470));
right.background = Color.new255(255, 215, 0); // gold
right.decorator = FlowLayout(bounds: right.bounds, margin: 75@25, gap: 15@15);
4.do({
	var button;
	button = Button.new(parent: right, bounds: 95@95);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds: 95@95);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds:  95@95);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds:  95@95);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});


// darth vader
vader = CompositeView(parent: composite, bounds: Rect(10, 280, 250, 260));
vader.background = Color.new255(255, 240, 245); // Lavender

// slider
slider = Slider.new(parent: composite, bounds: Rect(260, 480, 580, 60));
slider.background_(Color.new255(176, 226, 255)); // Sky Blue

)