// fix width -- done!
// fix buttons -- done!!
// measure up QuNeo
// refer to SCLOrkSynths
// match up Composite View dimensions with window dimensions -- done !!
// build smaller Composite Buttons
// don't hardcode dimensions, use variables!
(
var window, composite, left, right, vader, footer, text, text2, slider; // must happen first
Window.closeAll;
window = Window.new(name: "QuNeo", bounds: Rect(275, 163, 900, 600), resizable: false).front;
composite = CompositeView(parent: window, bounds: Rect(0, 0, 900, 600));
// composite = CompositeView(parent: window, bounds: Rect(25, 25, 850, 550));
composite.background = Color.black;


// want it above
// left side
// using compositeviews instead of flowlayouts
left = CompositeView(parent: composite, bounds: Rect(35, 35, 250, 270));
left.background = Color.new255(127, 255, 212); // aquamarine

// 16 buttons
right = CompositeView(parent: composite, bounds: Rect(285, 35, 580, 470));
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
vader = CompositeView(parent: composite, bounds: Rect(35, 305, 250, 260));
vader.background = Color.new255(255, 240, 245); // Lavender

// footer
footer = CompositeView(parent: composite, bounds: Rect(285, 505, 580, 60));
footer.background = Color.new255(176, 226, 255); // Sky Blue

// text
// text = StaticText(parent: footer, bounds: Rect(80, 10, 80, 30));
text = StaticText(parent: footer, bounds: Rect(100, 10, 70, 30));
text.string = "SCLOrk";
// text.background = Color.white;
text.align = \left;
text.font = Font(name: "Times", size: 20, italic: true); //size

text2 = StaticText(parent: footer, bounds: Rect(415, 10, 60, 30));
text2.string = "QuNeo";
// text2.background = Color.white;
text2.align = \left;
text2.font = Font(name: "Monaco", size: 20, bold: true);
// slider
slider = Slider.new(parent: footer, bounds: Rect(97, 35, 380, 30));
slider.background_(Color.new255(219, 112, 147)); // pale violet red
)