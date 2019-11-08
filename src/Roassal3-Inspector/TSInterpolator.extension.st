Extension { #name : #TSInterpolator }

{ #category : #'*Roassal3-Inspector' }
TSInterpolator >> gtCanvasForInspector [
	| canvas theme boxes pos rect line cp label loc s |
 	canvas := RSCanvas new.
	theme := Smalltalk ui theme.
	canvas color: theme backgroundColor.
	s := TSScale linear domain: #(1 100); range: #(0 420).
	boxes := (0 to: 99) collect: [ :i |
		RSBox new
			size: 40;
			x: (s scale: (i / 10) asInteger) * 10 + 64;
			y: (s scale: (i % 10) asInteger) * 10 + 64;
			color: (theme caretColor alpha: 0.2);
			resetBBox;
			yourself ] as: RSGroup.
	rect := boxes encompassingRectangle.
	pos := TSScale linear
		domain: { 0@0. 1@1 };
		range: { 0 @ rect height. rect width@ 0 }.
	line := RSPolyline new 
		border: (RSBorder new 
			width: 4;
			paint: (RSGradientPalette sweetPeriod
				start: rect bottomLeft;
				stop: rect topRight;
				yourself
			) ).
	canvas addShape: line.
	cp := OrderedCollection new.
	canvas newAnimation
		duration: 5 seconds;
		onStepDo: [ :t |
			cp add: t.
			line controlPoints: (cp collect: [:value | 
				pos scale: value @ (self interpolate: value) ]).
			canvas signalUpdate].
	canvas addAll: boxes.
	label := [ :text | 
		RSLabel new
			color: theme textColor;
			size: 20;
			text: text;
			yourself ].
	canvas addShape: (label value: '1').
	loc := RSLocation new outer.
	loc top; right;
		move: canvas shapes last on: rect.
	canvas addShape: (label value: '0').
	loc bottom; left;
		move: canvas shapes last on: rect.
	canvas addShape: (label value: 'Y').
	loc top; left;
		move: canvas shapes last on: rect.
	canvas addShape: (label value: 'X').
	loc bottom; right;
		move: canvas shapes last on: rect.
	canvas @ RSControlsCanvas.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
TSInterpolator >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Interpolator'];
		initializeCanvas: [ self gtCanvasForInspector ]
]
