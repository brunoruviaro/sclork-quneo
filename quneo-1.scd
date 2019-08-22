// v1.0: built colors but can't figure layout
(
var window, composite, left, right, vader, slider; // must happen first
Window.closeAll;
window = Window.new(name: "QuNeo", bounds: Rect(275, 163, 900, 600), resizable: false).front;
composite = CompositeView(parent: window, bounds: Rect(25, 25, 850, 550));
composite.background = Color.black;
composite.decorator = FlowLayout(bounds: composite.bounds);

// want it above
// left side
// using compositeviews instead of flowlayouts
left = CompositeView(parent: composite, bounds: Rect(10, 10, 250, 270));
left.background = Color.new255(127, 255, 212); // aquamarine

// 16 buttons
right = CompositeView(parent: composite, bounds: Rect(10, 10, 500, 270));
right.background = Color.new255(255, 215, 0); // gold
right.decorator = FlowLayout(bounds: right.bounds);
4.do({
	var button;
	button = Button.new(parent: right, bounds: 80@80);
	button.states = [["yes", Color.black, Color.white], ["no", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds: 80@80);
	button.states = [["yes", Color.black, Color.white], ["no", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds: 80@80);
	button.states = [["yes", Color.black, Color.white], ["no", Color.white, Color.black]];
});
right.decorator.nextLine;
4.do({
	var button;
	button = Button.new(parent: right, bounds: 80@80);
	button.states = [["yes", Color.black, Color.white], ["no", Color.white, Color.black]];
});

// want it below
composite.decorator.nextLine;

// darth vader
vader = CompositeView(parent: composite, bounds: Rect(10, 10, 250, 270));
vader.background = Color.new255(255, 240, 245); // Lavender

// slider
slider = Slider.new(parent: composite, bounds: 500@50);
slider.background_(Color.new255(176, 226, 255)); // Sky Blue
)

// can't split
// margin and top isnt working for FlowLayout