(
// must happen first
var window, composite, left, right, vader, footer; // main components of box model
var top, bottom1, bottom2; // components of left: 4 buttons on top
var k1, k2, nose, s1, s2, s3, s4; // components of vader: 2 knobs, a nose, 4 sliders
var text, text2, slider, b1, b2, b3, b4; // components of footer: 2 texts, 1 slider, and 4 buttons


Window.closeAll;
window = Window.new(name: "QuNeo", bounds: Rect(275, 163, 900, 600), resizable: false).front;
composite = CompositeView(parent: window, bounds: Rect(0, 0, 900, 600));
composite.background = Color.black;

// ************************************ LEFT ***************************************
left = CompositeView(parent: composite, bounds: Rect(35, 35, 250, 270));

// top buttons
top = CompositeView(parent: left, bounds:Rect(0, 30, 250, 60));
// top.background = Color.new255(255, 250, 205); // lime
top.decorator = FlowLayout(bounds: top.bounds, margin:15@3, gap: 25@25);
4.do({
	var tb; // buttons on top
	tb = Button(parent: top, bounds: 35@35);
	tb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

// bottom combinations

// bottom left
bottom1 = CompositeView(parent: left, bounds: Rect(0, 75, 83, 170));
// bottom1.background = Color.new255(224, 102, 255); // bright purple
bottom1.decorator = FlowLayout(bounds: bottom1.bounds, margin: 15@15, gap: 5@15);
8.do({
	var lb; // lower buttons
	lb = Button(parent:bottom1, bounds: 20@20);
	lb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

// bottom right
bottom2 = CompositeView(parent: left, bounds: Rect(83, 65, 166, 180));
bottom2.decorator = FlowLayout(bounds: bottom2.bounds, margin: 15@15, gap: 10@10);
4.do({
	var ls; //lower sliders
	ls = Slider(parent: bottom2, bounds: 140@25);
	ls.background = Color.white;
});


// ************************************ RIGHT ***************************************
// 16 buttons
right = CompositeView(parent: composite, bounds: Rect(285, 35, 580, 470));
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

// ********************************* DARTH VADER *************************************
// darth vader
vader = CompositeView(parent: composite, bounds: Rect(35, 305, 250, 260));

// knobs
k1 = Knob(parent: vader, bounds: Rect(10, 0, 95, 95));
k2 = Knob(parent: vader, bounds: Rect(135, 0, 95, 95));

// nose
nose = Button(parent: vader, bounds: Rect(112.5, 75, 15, 15));
nose.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

// sliders
s1 = Slider.new(parent: vader, bounds: Rect(35, 105, 30, 150));
s1.background_(Color.white);

s2 = Slider.new(parent: vader, bounds: Rect(85, 105, 30, 150));
s2.background_(Color.white);

s3 = Slider.new(parent: vader, bounds: Rect(135, 105, 30, 150));
s3.background_(Color.white);

s4 = Slider.new(parent: vader, bounds: Rect(185, 105, 30, 150));
s4.background_(Color.white);

// ************************************ FOOTER ***************************************
// footer
footer = CompositeView(parent: composite, bounds: Rect(285, 505, 580, 60));

// upper left button
b1 = Button(parent: footer, bounds: Rect(35, 0, 25, 25));
b1.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

// lower left button
b2 = Button(parent: footer, bounds: Rect(35, 30, 25, 25));
b2.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

// text
text = StaticText(parent: footer, bounds: Rect(100, 0, 70, 30));
text.string = "SCLOrk";
text.align = \left;
text.font = Font(name: "Times", size: 20, italic: true);
text.stringColor = Color.white;

text2 = StaticText(parent: footer, bounds: Rect(415, 0, 60, 30));
text2.string = "QuNeo";
text2.align = \left;
text2.font = Font(name: "Monaco", size: 20, bold: true);
text2.stringColor = Color.white;

// slider
slider = Slider.new(parent: footer, bounds: Rect(97, 25, 380, 30));
slider.background_(Color.white);

// upper right button
b3 = Button(parent: footer, bounds: Rect(515, 0, 25, 25));
b3.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

// lower right button
b4 = Button(parent: footer, bounds: Rect(515, 30, 25, 25));
b4.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

)