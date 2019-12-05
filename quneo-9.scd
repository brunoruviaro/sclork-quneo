(
// must happen first
var window, windowWidth, windowHeight;
var leftTop, leftTopW, leftTopH;
var leftBottom, leftBottomW, leftBottomH;
var right, rightW, rightH;
var vader, vaderW, vaderH;
var footer, footerW, footerH;
var up, down, k1, k2, nose; // components of vader: 2 knobs, a nose, 4 sliders
var lb, rb, mid1, mid2, text, text2, slider; // components of footer: 2 texts, 1 slider, and 4 buttons


Window.closeAll;

windowWidth = 815;
windowHeight = 600;

// leftmost column occupies 1/3 of window width
leftTopW = windowWidth * 1/3;
leftBottomW = windowWidth * 1/3;
vaderW = windowWidth * 1/3;

// leftmost column is split vertically this way among its parts
leftTopH = windowHeight * 1/10;
leftBottomH = windowHeight * 4/10;
vaderH = windowHeight * 5/10;

// right column occupies the rest of window width
rightW = windowWidth * 2/3;
footerW = windowWidth * 2/3;

// right column vertical spacing
rightH = windowHeight * 9/10;
footerH = windowHeight * 1/10;




window = Window.new(name: "QuNeo", bounds: Rect(
	left: 275,
	top: 163,
	width: windowWidth,
	height: windowHeight
),
resizable: false
).front;

window.background = Color.black;

// window = CompositeView(parent: window, bounds: Rect(0, 0, 900, 600));
// window.background = Color.black;

// ************************************ LEFT ***************************************
leftTop = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: 0,
		width: leftTopW,
		height: leftTopH
	)
);

leftTop.background = Color.red;

// top buttons
/*top = CompositeView(parent: left, bounds:Rect(0, 0, windowWidth * 1/3, 60));*/
leftTop.decorator = FlowLayout(bounds: leftTop.bounds, margin:25@12, gap: 25@25);
4.do({
	var tb; // buttons on top
	tb = Button(parent: leftTop, bounds: 35@35);
	tb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

leftTop.background = Color.white;

// bottom combinations

leftBottom = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: leftTopH,
		width: leftBottomW,
		height: leftBottomH
	)
);

leftBottom.background = Color.rand;

leftBottom.decorator = FlowLayout(
	bounds: leftBottom.bounds,
	margin: 18@18,
	gap: 7@20
);

4.do({
	Button(parent: leftBottom, bounds: 25@35);
	Button(parent: leftBottom, bounds: 25@35);
	Slider(parent: leftBottom, bounds: 170@35);
});
/*
// bottom left
bottom1 = CompositeView(parent: left, bounds: Rect(0, 60, 83, 170));
bottom1.background = Color.rand;
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

*/


// ************************************ RIGHT ***************************************
// 16 buttons
right = CompositeView(
	parent: window,
	bounds: Rect(
		left: leftTopW,
		top: 0,
		width: rightW,
		height: rightH;
	)
);

right.decorator = FlowLayout(bounds: right.bounds, margin: 12@12, gap: 12@12);
16.do({
	var button;
	button = Button.new(parent: right, bounds: 120@120);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});

right.background = Color.green;

// ********************************* DARTH VADER *************************************
// darth vader
vader = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: leftTopH + leftBottomH,
		width: vaderW,
		height: vaderH
	)
);

vader.background = Color.gray;

up = CompositeView(parent: vader, bounds: Rect(0, 0, vaderW, vaderH * 1/3));
up.background = Color.rand;
// knobs
k1 = Knob(parent: vader, bounds: Rect(15, 15, 95, 95));
k2 = Knob(parent: vader, bounds: Rect(140, 15, 95, 95));

// nose
nose = Button(parent: vader, bounds: Rect(vaderW / 2 -10, 75, 15, 15));
nose.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];

down = CompositeView(parent: vader, bounds: Rect(0, up.bounds.height, vaderW, vaderH * 2/3));

down.background = Color.rand;

down.decorator = FlowLayout(bounds: down.bounds, margin: 35@10, gap: 20@0);
4.do({
	var slider = Slider.new(parent: down, bounds: 30@150);
	slider.background_(Color.white);
});

// ************************************ FOOTER ***************************************
// footer
footer = CompositeView(
	parent: window,
	bounds: Rect(
		left: vaderW,
		top: rightH,
		width: footerW,
		height: footerH
	)
);

footer.background = Color.rand;

// buttons on the left layout
lb = CompositeView(parent: footer, bounds: Rect(0, 0, 90, 60));
lb.decorator = FlowLayout(bounds: lb.bounds, margin: 32@2, gap: 50@7);

lb.background = Color.rand;
// buttons
2.do({
	var b = Button(parent: lb, bounds: 25@25);
	b.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});


// upper middle part with the 2 strings
mid1 = CompositeView(parent: footer, bounds: Rect(90, 0, 400, 30));
mid1.decorator = FlowLayout(bounds: mid1.bounds, margin: 0@0, gap: 0@0);

text = StaticText(parent: mid1, bounds: Rect(0, 0, 200, 30));
text.string = "SCLOrk";
text.align = \left;
text.font = Font(name: "Times", size: 20, italic: true);
text.stringColor = Color.white;

text2 = StaticText(parent: mid1, bounds: Rect(200, 0, 200, 30));
text2.string = "QuNeo";
text2.align = \right;
text2.font = Font(name: "Monaco", size: 20, bold: true);
text2.stringColor = Color.white;

// lower middle part with slider
mid2 = CompositeView(parent: footer, bounds: Rect(90, 30, 400, 30));
slider = Slider.new(parent: mid2, bounds: Rect(10, 0, 380, 30));
slider.background_(Color.white);


// buttons on the right layout
rb = CompositeView(parent: footer, bounds: Rect(490, 0, 90, 60));
rb.decorator = FlowLayout(bounds: rb.bounds, margin: 20@2, gap: 4@7);

// buttons
2.do({
	var b = Button(parent: rb, bounds: 25@25);
	b.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});
)