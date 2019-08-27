(
// must happen first
var window, composite, left, right, vader, footer; // main components of box model
var top, bottom1, bottom2; // components of left: 4 buttons on top
var up, down, k1, k2, nose, s1, s2, s3, s4; // components of vader: 2 knobs, a nose, 4 sliders
var lb, rb, mid1, mid2, text, text2, slider; // components of footer: 2 texts, 1 slider, and 4 buttons


Window.closeAll;
window = Window.new(name: "QuNeo", bounds: Rect(275, 163, 900, 600), resizable: false).front;
composite = CompositeView(parent: window, bounds: Rect(0, 0, 900, 600));
composite.background = Color.black;

// ************************************ LEFT ***************************************
left = CompositeView(parent: composite, bounds: Rect(35, 35, 250, 270));

// top buttons
top = CompositeView(parent: left, bounds:Rect(0, 30, 250, 60));
top.background = Color.new255(255, 250, 205); // lime
top.decorator = FlowLayout(bounds: top.bounds, margin:15@3, gap: 25@25);
4.do({
	var tb; // buttons on top
	tb = Button(parent: top, bounds: 35@35);
	tb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

// bottom combinations

// bottom left
bottom1 = CompositeView(parent: left, bounds: Rect(0, 75, 83, 170));
bottom1.background = Color.new255(224, 102, 255); // bright purple
bottom1.decorator = FlowLayout(bounds: bottom1.bounds, margin: 15@15, gap: 5@15);
8.do({
	var lb; // lower buttons
	lb = Button(parent:bottom1, bounds: 20@20);
	lb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

// bottom right
bottom2 = CompositeView(parent: left, bounds: Rect(83, 65, 166, 180));
bottom2.background = Color.grey;
bottom2.decorator = FlowLayout(bounds: bottom2.bounds, margin: 15@15, gap: 10@10);
4.do({
	var ls; //lower sliders
	ls = Slider(parent: bottom2, bounds: 140@25);
	ls.background = Color.white;
});


// ************************************ RIGHT ***************************************
// 16 buttons
right = CompositeView(parent: composite, bounds: Rect(285, 35, 580, 470));
right.background = Color.cyan;
right.decorator = FlowLayout(bounds: right.bounds, margin: 50@15, gap: 25@15);
16.do({
	var button;
	button = Button.new(parent: right, bounds: 100@100);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

// ********************************* DARTH VADER *************************************
// darth vader
vader = CompositeView(parent: composite, bounds: Rect(35, 305, 250, 260));
vader.background = Color.grey;

up = CompositeView(parent: vader, bounds: Rect(0, 0, 250, 95));
up.background = Color.green;
// knobs
k1 = Knob(parent: vader, bounds: Rect(15, 0, 95, 95));
k2 = Knob(parent: vader, bounds: Rect(140, 0, 95, 95));

// nose
nose = Button(parent: vader, bounds: Rect(115.5, 75, 15, 15));
nose.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

down = CompositeView(parent: vader, bounds: Rect(0, 95, 250, 170));
down.background = Color.blue;
down.decorator = FlowLayout(bounds: down.bounds, margin: 35@0, gap: 20@0);
4.do({
	var slider = Slider.new(parent: down, bounds: 30@150);
});

/*
up = CompositeView(parent: vader, bounds: Rect(0, 0, 250, 95));
up.background = Color.green;
// 15 from left; 125 between
up.decorator = FlowLayout(bounds: up.bounds, margin: 15@0, gap: 25@0);
2.do({
	var knob = Knob(parent: up, bounds: 95@95);
});
*/
// ************************************ FOOTER ***************************************
// footer
footer = CompositeView(parent: composite, bounds: Rect(285, 505, 580, 60));
footer.background = Color.grey;

// buttons on the left layout
lb = CompositeView(parent: footer, bounds: Rect(0, 0, 90, 60));
lb.background = Color.magenta;
lb.decorator = FlowLayout(bounds: lb.bounds, margin: 32@2, gap: 50@7);

// buttons
2.do({
	var b = Button(parent: lb, bounds: 25@25);
	b.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});


// upper middle part with the 2 strings
mid1 = CompositeView(parent: footer, bounds: Rect(90, 0, 400, 30));
mid1.background = Color.blue;
mid1.decorator = FlowLayout(bounds: mid1.bounds, margin: 0@0, gap: 0@0);

text = StaticText(parent: mid1, bounds: Rect(0, 0, 200, 30));
text.background = Color.black;
text.string = "SCLOrk";
text.align = \left;
text.font = Font(name: "Times", size: 20, italic: true);
text.stringColor = Color.white;

text2 = StaticText(parent: mid1, bounds: Rect(200, 0, 200, 30));
text2.background = Color.green;
text2.string = "QuNeo";
text2.align = \right;
text2.font = Font(name: "Monaco", size: 20, bold: true);
text2.stringColor = Color.white;

// lower middle part with slider
mid2 = CompositeView(parent: footer, bounds: Rect(90, 30, 400, 30));
mid2.background = Color.cyan;
slider = Slider.new(parent: mid2, bounds: Rect(10, 0, 380, 30));
slider.background_(Color.white);



// buttons on the right layout
rb = CompositeView(parent: footer, bounds: Rect(490, 0, 90, 60));
rb.background = Color.magenta;
rb.decorator = FlowLayout(bounds: rb.bounds, margin: 20@2, gap: 4@7);

// buttons
2.do({
	var b = Button(parent: rb, bounds: 25@25);
	b.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});



)