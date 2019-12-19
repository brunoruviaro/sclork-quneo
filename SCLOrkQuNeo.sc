
/*
MIDIIn.connectAll;



MIDIClient.init;
z = SCLOrkQuNeo.new;
// user code
z.onButtonChange = { |velocity, midinote| ["WOW", velocity, midinote].postln };
z.onConnectMIDI(true);

MIDIFunc.trace(true);
MIDIFunc.trace(false);

NEXT STEPS:
I ended on Wed Dec 18 with
- two new QuNeo presets, 3 and 4, where vader nose sends midinote 19
- midinote 19 is detected in code to switch banks for the 16 pads
- works fine with preset 3, but preset 4 (toggle) needs work. I can no longer rely on QuNeo automated LED control. I will have to keep state of each button and send LED on and off accordingly. When switching to a new bank, code will have to take care of turning off LEDs from previous bank, and on LEDs for new bank.
Might as well do that for Preset 3...?





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
	var guiPreset;
	var bank;

	var <>onButtonChange;
	var <>midiChannel = 11; // SCLOrk QuNeos are always channel 11


	*new { |action| ^super.new.init(action); }


	init { |argAction|
		Window.closeAll;

		// start GUI in Preset 1 (P3), bank 0
		guiPreset = 1;
		bank = 0;

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

		// Button 126 allows user to switch GUI from Preset 3 (P3) to Preset 4 (P4),
		// This mimicks P3 and P4 behavior of QuNeo SCLOrk presets.
		// Button 126 will *not* respond to MIDI -- it's a GUI-only option.
		buttonArray[126] = Button(parent: leftTop, bounds: 35@35)
		.states_([
			["P3", Color.black, Color.white],
			["P4", Color.white, Color.black]
		])
		.action_({ |b|
			guiPreset = b.value + 1; // switch between presets 3 or 4
			["Current preset", guiPreset].postln;
		});

		// Create next three buttons on topLeft: QuNeo's diamond, square, triangle
		// Button numbers correspond to QuNeo preset midinote numbers.
		// Buttons are stored at array slot corresponding to midinote number
		// These buttons only have velocity 0 and 127, nothing in between
		[24, 25, 26].do({ |midinote|
			var downColor =
			switch( midinote,
				24, {Color.red},
				25, {Color.yellow},
				26, {Color.green}
			);
			buttonArray[midinote] = Button(parent: leftTop, bounds: 35@35)
			.states_([
				[midinote, Color.black, Color.white],
				[midinote, Color.black, downColor] // color when pushed in and held
			])
			.mouseDownAction_({
				buttonArray[midinote].valueAction = 1;
				this.onUIButtonChange(
					velocity: 127,
					midinote: midinote
				);
			})
			.action_({ |button|
				// "note off" action
				if(button.value==0, {
					this.onUIButtonChange(
						velocity: 0,
						midinote: midinote
				)});
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
		// Each one will hold 16 buttons
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

		// Populate buttonArray with 16x4 buttons
		// Buttons get assigned into array slots corresponding to their midinote number
		Array.fill(16*4, { |i|
			var index = i.mod(16);
			var layer = i.div(16);
			var midinote;
			// use midinote numbers as button number:
			midinote = buttonNamesAsMidinotes[index] + (16 * layer);
			buttonArray[midinote] = Button.new(right[layer], 120@120)
			.states_([
				[midinote, Color.black, Color.white],
				[midinote, Color.white, Color.black]
			])
			.mouseDownAction_({ |velocity|
				// This function only used in Preset 1.
				if(guiPreset==1, {
					velocity = if(velocity.isNumber, {velocity}, {127});
					buttonArray[midinote].valueAction = 1;
					this.onUIButtonChange(velocity, midinote);
				});
			})
			.action_({ |velocity|
				// is incoming arg a number? (if not, it's a Button)
				velocity = if(velocity.isNumber, {velocity}, {velocity.value * 127});
				if(guiPreset==1, {
					if(velocity==0, {
						this.onUIButtonChange(
							velocity: 0,
							midinote: midinote
					)});
				});
				if(guiPreset==2, {
					this.onUIButtonChange(
						velocity: velocity,
						midinote: midinote
				)});
			})
		});

		/* mouseDownAction and action functions above may be called from either a regular GUI button press, or from a MIDIdef listening to QuNeo buttons. When called from the MIDIdef, QuNeo velocity is passed as arg. When called by regular GUI button press, the button itself is passed as arg, in which case we ignore it and assign a default velocity of 127. */

		// first layer is on top at start
		right[0].front;


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
			bank = button.value;
			right[bank].front;
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

	onUIButtonChange { |velocity, midinote|
		this.onButtonChange.value(velocity, midinote)
	}

	onConnectMIDI { | doConnect |
		if (doConnect, {
			var midiPort;
			var toQuNeo;

			// create MIDIOut to send LED info back to Rhombus button on QuNeo
			toQuNeo = MIDIOut(0);

			midiPort = MIDIIn.findPort("QUNEO", "QUNEO MIDI 1");
			// .notNil or: MIDIIn.findPort("QUNEO", "QUNEO").notNil;

			midiPort.postln;
			midiPort.uid.postln;

			if (midiPort.notNil, {
				"about to create MIDIdefs".postln;

				MIDIdef.noteOn(
					key: \nose,
					func: { |v, n|
						bank = (bank + 1).mod(4);
						{ nose.valueAction = bank }.defer;
						// send LED info back to QuNeo Rhombus button
						bank.postln;
						"ASDFSADF".postln;
						switch(bank,
							0, { // LEDs off
								"xxxxx".postln;
								toQuNeo.noteOn(0, 44, 0);
								toQuNeo.noteOn(0, 45, 0);
							},
							1, { // LEDs green
								toQuNeo.noteOn(0, 44, 127);
								toQuNeo.noteOn(0, 45, 0);
							},
							2, { // LEDs orange
								toQuNeo.noteOn(0, 44, 127);
								toQuNeo.noteOn(0, 45, 127);
							},
							3, { // LEDs red
								toQuNeo.noteOn(0, 44, 0);
								toQuNeo.noteOn(0, 45, 127);
							}
						);
					},
					noteNum: 19,
					chan: midiChannel
				).permanent_(true);

				MIDIdef.noteOn(
					key: \on,
					func: { | velocity, midinote |

						case
						{bank==0} {midinote}
						{bank==1} {midinote = midinote + 16}
						{bank==2} {midinote = midinote + 32}
						{bank==3} {midinote = midinote + 48}
						;

						{
							if(guiPreset==1, {
								buttonArray[midinote].mouseDownAction.value(velocity)
							}, {
								buttonArray[midinote].action.value(velocity)
							})
						}.defer;

						["MIDIdef.noteOn", velocity, midinote].postln;
					},
					noteNum: (0..18)++(20..125), // ignore midinote 19 (darth vader nose)
					chan: midiChannel,
					// srcID: midiPort.uid
				).permanent_(true);

				"after noteOn mididef".postln;

				MIDIdef.noteOff(
					key: \off,
					func: { | velocity, midinote |

						case
						{bank==0} {midinote}
						{bank==1} {midinote = midinote + 16}
						{bank==2} {midinote = midinote + 32}
						{bank==3} {midinote = midinote + 48}
						;

						{ buttonArray[midinote].valueAction = 0 }.defer;

						["MIDIdef.noteOff", velocity, midinote].postln;
					},
					noteNum: (0..18)++(20..125), // ignore midinote 19 (darth vader nose)
					chan: midiChannel
					// srcID: midiPort.uid
				).permanent_(true);

			}, {
				"MIDIIn unable to find QuNeo".postln;
				// midi_button.value = 0;
			});
		}, {
			"free MIDIdefs".postln;
			MIDIdef.noteOn(\nose).free;
			MIDIdef.noteOn(\on).free;
			MIDIdef.noteOff(\off).free;
		});
	}

	// Returns boolean: true if QuNeo is detected.
	isPhysicalDeviceConnected {
		^(MIDIIn.findPort("QUNEO", "QUNEO").notNil);
	}


} // EOF