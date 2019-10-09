Extension { #name : #TSInterpolator }

{ #category : #'*Roassal3-Inspector' }
TSInterpolator >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Interpolator'];
		initializeView: [ self gtViewForInspector ]
]

{ #category : #'*Roassal3-Inspector' }
TSInterpolator >> gtViewForInspector [
	| view theme boxBuilder boxes pos rect line cp label loc |
 	view := RSView new.
	theme := Smalltalk ui theme.
	view color: theme backgroundColor.
	boxBuilder := RSShapeBuilder box
		size: 40;
		color: (theme caretColor alpha: 0.2).
	boxes := boxBuilder elementsOn: (1 to: 100).
	RSGridLayout new 
		lineItemsCount: 10;
		gapSize: 2; 
		on: boxes.
	rect := boxes encompassingRectangle.
	pos := TSScale linear
		domain: { 0@0. 1@1 };
		range: { 0 @ rect height. rect width@ 0 }.
	line := TSPolyline new 
		border: (TSBorder new 
			width: 4;
			paint: (TSGradientPalette sweetPeriod
				start: rect bottomLeft;
				stop: rect topRight;
				yourself
			) ).
	view addShape: line.
	cp := OrderedCollection new.
	view newAnimation
		duration: 5 seconds;
		onStepDo: [ :t |
			cp add: t.
			line controlPoints: (cp collect: [:value | 
				pos scale: value @ (self interpolate: value) ]).
			view signalUpdate].
	view addAll: boxes.
	label := RSShapeBuilder label
		color: theme textColor;
		size: 20.
	view add: (label elementOn: 1).
	loc := RSLocation new outer.
	loc top; right;
		move: view elements last on: rect.
	view add: (label elementOn: 0).
	loc bottom; left;
		move: view elements last on: rect.
	view add: (label elementOn: 'Y').
	loc top; left;
		move: view elements last on: rect.
	view add: (label elementOn: 'X').
	loc bottom; right;
		move: view elements last on: rect.
	view @ TSControlsCanvas.
	^ view
]
