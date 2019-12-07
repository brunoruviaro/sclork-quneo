(
var window, windowWidth, windowHeight; // main window
var leftTop, leftTopW, leftTopH; // top left 4-button row
var leftBottom, leftBottomW, leftBottomH; // buttons and Hsliders above vader
var right, rightW, rightH; // 16-button main panel
var vader, vaderW, vaderH; // darth vader (lower left box)
var footer, footerW, footerH; // buttons and slides below 16-button panel
var up, down, k1, k2, nose; // components of vader: 2 knobs, 1 nose, 4 Vsliders
var lb, rb, mid1, mid2, text, text2, slider; // components of footer: 2 texts, 1 slider, 4 buttons


Window.closeAll;

/*

These variables hold CompositeViews placed onto main window:
___________________________
|  leftTop   |              |
|____________|              |
|            |              |
| leftBottom |     right    |
|            |              |
|____________|              |
|            |              |
|    vader   |              |
|            |______________|
|            |   footer     |
|____________|______________|

*/

windowWidth = 840;
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




window = Window.new(name: "SCLOrkQuNeo", bounds: Rect(
	left: 275,
	top: 163,
	width: windowWidth,
	height: windowHeight
),
resizable: false
).front;

window.background = Color.black;


// ================
// *** leftTop ***
// ================

leftTop = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: 0,
		width: leftTopW,
		height: leftTopH
	)
);

leftTop.decorator = FlowLayout(bounds: leftTop.bounds, margin:25@20, gap: 25@25);
4.do({
	var tb; // buttons on top
	tb = Button(parent: leftTop, bounds: 35@35);
	tb.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});


// ==================
// *** leftBottom ***
// ==================


leftBottom = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: leftTopH,
		width: leftBottomW,
		height: leftBottomH
	)
);

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


// =============
// *** right ***
// (16-button box)
// =============

right = CompositeView(
	parent: window,
	bounds: Rect(
		left: leftTopW,
		top: 0,
		width: rightW,
		height: rightH;
	)
);

right.decorator = FlowLayout(bounds: right.bounds, margin: 12@12, gap: 15@15);
16.do({
	var button;
	button = Button.new(parent: right, bounds: 120@120);
	button.states = [["", Color.black, Color.white], ["", Color.white, Color.black]];
});


// =============
// *** vader ***
// =============

vader = CompositeView(
	parent: window,
	bounds: Rect(
		left: 0,
		top: leftTopH + leftBottomH,
		width: vaderW,
		height: vaderH
	)
);

// vader.background = Color.gray;

// , bounds: Rect(140, 15, 95, 95)

k1 = Knob(parent: vader).minHeight_(105);
k2 = Knob(parent: vader).minHeight_(105);

// nose is hard coded in the right spot
nose = Button(parent: vader, bounds: Rect(vader.bounds.width / 2 - 15, 95, 30, 30));

vader.layout = VLayout(
	HLayout(
		k1, k2

	),
	10, // empty space
	HLayout(
		10,
		Slider.new(parent: vader),
		10,
		Slider.new(parent: vader),
		10,
		Slider.new(parent: vader),
		10,
		Slider.new(parent: vader),
		10
	)
);


// ===============
// *** footer ***
// ===============

footer = CompositeView(
	parent: window,
	bounds: Rect(
		left: vaderW,
		top: rightH,
		width: footerW,
		height: footerH
	)
);

slider = Slider(footer).orientation_(\horizontal);

footer.layout = HLayout(
	2,
	// footer left buttons
	VLayout(
		Button(parent: footer),
		Button(parent: footer)
	),
	// footer long slider
	[slider, stretch: 1],
	// foitems: oter right buttons
	VLayout(
		Button(parent: footer),
		Button(parent: footer)
	),
	15
);

) // EOF