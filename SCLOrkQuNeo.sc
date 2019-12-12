
/*
MIDIIn.connectAll;



z = SCLOrkQuNeo.new;

// user code
z.onButtonChange = { |note, velocity| ["WOW", note, velocity].postln };

z.onConnectMIDI(true);

NEXT STEPS:
I ended on Friday Dec 6 with the top row of 3 buttons (leftTop) able to respond to mouse down and hold, then release.

I need to come up with a way to let user of GUI select QuNeo Preset 1 or 2.

In preset 1, 16 buttons need to behave in this 'one shot' mode like other buttons.
In preset 2, 16 buttons behave in the usual click and stay on mode, until clicked again to turn off.

GUI has no way to tell which mode QuNeo is in, and it does not matter.

So the user needs to select GUI mode, "One-shot" or "Stay On" (preset 1 or 2).



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

SCLOrkQuNeo {
	var buttonArray, buttonNamesAsMidinotes;
	var window, windowWidth, windowHeight; // main window
	var leftTop, leftTopW, leftTopH; // top left 4-button row
	var leftBottom, leftBottomW, leftBottomH; // buttons and Hsliders above vader
	var right, rightW, rightH; // 16-button main panel
	var vader, vaderW, vaderH; // darth vader (lower left box)
	var footer, footerW, footerH; // buttons and slides below 16-button panel
	var up, down, k1, k2, nose; // components of vader: 2 knobs, 1 nose, 4 Vsliders
	var slider;

	var <>onButtonChange;
	var <>midiChannel = 11; // SCLOrk QuNeos are always channel 11


	*new { |action| ^super.new.init(action); }


	init { |argAction|
		Window.closeAll;

		// create empty button array to hold all Buttons
		buttonArray = Array.newClear(127);

		// create main window
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

		// button names correspond to QuNeo preset midinote numbers.
		// note: button zero does not really do anything on the GUI
		[0, 24, 25, 26].do({ |i|
			var downColor =
			switch( i,
				0, {Color.white},
				24, {Color.red},
				25, {Color.yellow},
				26, {Color.green}
			);
			// buttons on top left
			buttonArray[i] = Button(parent: leftTop, bounds: 35@35)
			.states_([
				[i, Color.gray, Color.white],
				[i, Color.white, downColor] // color when pushed in and held
			])
			.name_(i)
			.mouseDownAction_({ |vel|
				buttonArray[i].valueAction = 1;
				// [buttonArray[i].name, "down"].postln;
				this.onUIButtonChange(buttonArray[i].name.asInteger, if(vel.isNumber, {vel}, {"down"}))
			})
			.action_({ |vel|
				// "note off" action
				[buttonArray[i].name, buttonArray[i].value].postln;
				this.onUIButtonChange(buttonArray[i].name.asInteger, if(vel.isNumber, {vel}, {"up"}))
			})
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
		// 4 layers x 16 buttons
		// =============

		// Adding buttons through FlowLayout number buttons from left to right, top to bottom.
		// However, we want to follow the midinote mapping scheme of SCLOrk QuNeo presets,
		// which start from midinote 36 at lower left, then go left to right and bottom up.
		// This array is used for that purpose.
		buttonNamesAsMidinotes = [
			48, 49, 50, 51,
			44, 45, 46, 47,
			40, 41, 42, 43,
			36, 37, 38, 39
		];

		// Create array with 4 CompositeViews layered on top of each other
		// Each panel will hold 16 buttons
		// right[0] -> midinotes 36 to 51
		// right[1] -> midinotes 52 to 67
		// right[2] -> midinotes 68 to 83
		// right[3] -> midinotes 84 to 89
		right = Array.fill(4, {
			CompositeView(
				parent: window,
				bounds: Rect(
					left: leftTopW,
					top: 0,
					width: rightW,
					height: rightH;
				)
			);
		});

		right.do({ |cv| cv.decorator = FlowLayout(
			bounds: cv.bounds,
			margin: 12@12,
			gap: 15@15
		);
		});

		right[0].front;

		// Populate buttonArray with 16 buttons of main panel
		// Buttons get assigned into array slots corresponding to their midinote number
		Array.fill(16*4, { |i|
			var index = i.mod(16);
			var layer = i.div(16);
			var midinote;
			// use midinote numbers as button names / labels:
			["before", i].postln;
			midinote = buttonNamesAsMidinotes[index] + (16 * layer);
			["after", midinote].postln;
			buttonArray[midinote] = Button.new(right[layer], 120@120);
			buttonArray[midinote].name = midinote;
			buttonArray[midinote].states_([
				[midinote, Color.gray, Color.white],
				[midinote, Color.white, Color.black]
			]);
			buttonArray[midinote].action_({ |vel| this.onUIButtonChange(buttonArray[midinote].name.asInteger, vel) })
		});


		// first layer is on top at start
		// right[0].front;

		/*
		buttonNamesAsMidinotes.do({ |i|
		buttonArray[i] = Button.new(right, 120@120);
		buttonArray[i].name = i;
		buttonArray[i].states_([
		[i, Color.gray, Color.white],
		[i, Color.white, Color.red]
		]);
		buttonArray[i].action_({ |vel| this.onUIButtonChange(buttonArray[i].name.asInteger, vel) })
		});
		*/

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
		nose.states = [
			["", Color.gray, Color.white],
			["", Color.gray, Color.green],
			["", Color.gray, Color.new(1, 0.6)], // orange
			["", Color.gray, Color.red],
		];

		// change 16-button layer:
		nose.action = { |button|
			right[button.value].front;
		};

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

	} // end of init

	onUIButtonChange { | buttonNumber, value |
		this.onButtonChange.value(buttonNumber, value)
	}

	onConnectMIDI { | doConnect |
		if (doConnect, {
			var midiPort;
			midiPort = MIDIIn.findPort("QUNEO", "QUNEO MIDI 1");
			// .notNil or: MIDIIn.findPort("QUNEO", "QUNEO").notNil;
			midiPort.postln;
			midiPort.uid.postln;
			if (midiPort.notNil, {

				MIDIdef.noteOn(
					key: \on,
					func: { | vel, note |

						Task.new(
							func: {
								buttonArray[note].mouseDownAction.value(vel)
								/*
								if( buttonArray[note].mouseDownAction.notNil,
								{ buttonArray[note].mouseDownAction.value(vel) },
								{ buttonArray[note].action.value(vel) }
								)
								*/

							},
							clock: AppClock
						).start;

						// ["MIDIdef", vel, note].postln;
					},
					chan: midiChannel,
					srcID: midiPort.uid);

				MIDIdef.noteOff(
					key: \off,
					func: { | vel, note |
						var appAction = { buttonArray[note].action.value(vel) };
						if (appAction.notNil, { Task.new(appAction, AppClock).start});
						// ["MIDIdef", vel, note].postln;
					},
					chan: midiChannel,
					srcID: midiPort.uid);
				// midi_button.value = 1;

			}, {
				"MIDIIn unable to find QuNeo".postln;
				// midi_button.value = 0;
			});
		}, {
			"free MIDIdefs".postln;
			MIDIdef.noteOn(\on).free;
			MIDIdef.noteOff(\off).free;
		});
	}

	// Returns boolean: true if QuNeo is detected.
	isPhysicalDeviceConnected {
		^(MIDIIn.findPort("QUNEO", "QUNEO").notNil);
	}


} // EOF