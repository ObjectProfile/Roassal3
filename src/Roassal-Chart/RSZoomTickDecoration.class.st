"
this decoration is an example of how to put some interactions in the canvas and interact with some objects like the ticks in the chart
"
Class {
	#name : 'RSZoomTickDecoration',
	#superclass : 'RSAbstractChartDecoration',
	#instVars : [
		'resetLabel',
		'visibleRectangle',
		'currentShapes',
		'elasticBox'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'accessing' }
RSZoomTickDecoration >> boxScale [
	| spine |
	spine := chart spine encompassingRectangle.
	^ NSScale linear
		domain: { spine origin. spine corner };
		range: { visibleRectangle origin. visibleRectangle corner}
]

{ #category : 'accessing' }
RSZoomTickDecoration >> chartElements [
	| elements |
	elements := OrderedCollection new.
	elements addAll: chart plots.
	chart verticalTick ifNotNil: [:tick | elements add: tick ].
	chart horizontalTick ifNotNil: [:tick | elements add: tick ].
	^ elements
]

{ #category : 'accessing' }
RSZoomTickDecoration >> computeVisibleRectangle: eventRectangle [
	| rect spine scale |
	"spine the the chart box"
	spine := chart spine encompassingRectangle.
	rect := (eventRectangle origin max: spine origin)
		corner: (eventRectangle corner min: spine corner).
	scale := self boxScale.
	^ (scale scale: rect origin) corner: (scale scale: rect corner)
]

{ #category : 'accessing' }
RSZoomTickDecoration >> createElasticBox [
	^ RSElasticBoxInteraction new
		targetShapes: #();
		in: [ :elastic | elastic box border width: 0.2 ];
		when: RSSelectionEndEvent send: #updateSelection: to: self;
		yourself
]

{ #category : 'accessing' }
RSZoomTickDecoration >> createResetLabel [
	| label |
	label := self shape copy
		text: 'Reset zoom';
		when: RSMouseClick send: #resetZoom: to: self;
		yourself.
	label @ RSHighlightable blue.
	RSLocation new
		inner; top; right;
		move: label on: self chart spine.
	^ label
]

{ #category : 'accessing' }
RSZoomTickDecoration >> createdShapes [
	^ { resetLabel }
]

{ #category : 'initialization' }
RSZoomTickDecoration >> defaultShape [
	^ RSLabel new
		fontSize: 5;
		bold;
		yourself
]

{ #category : 'accessing' }
RSZoomTickDecoration >> elasticBox [
	^ elasticBox ifNil: [ elasticBox := self createElasticBox ]
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderIn: canvas [
	canvas addInteraction: self elasticBox.
	resetLabel := self createResetLabel.
	canvas add: resetLabel.

	currentShapes := #().
	self resetZoom: canvas
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderPlots [
	| visibleShapes scale |
	visibleShapes := chart createdShapes select: [ :s | s encompassingRectangle intersects: visibleRectangle ].
	scale := chart spine extent/visibleRectangle extent.
	"I use a composite shape because the composite can scale the selected shapes,
	but more important we can clip the selected shapes"
	visibleShapes := RSComposite new
		fromRectangle: visibleRectangle;
		addAll: (visibleShapes collect: [:s | | copy |
			"it is necessary to create a copy of the current shape because we will modify its position"
			copy := s copy.
			copy matrix: s matrix copy.
			copy translateBy: visibleRectangle floatCenter negated.
			copy ]);
		scaleBy: scale;
		translateBy: chart spine encompassingRectangle floatCenter - visibleRectangle floatCenter;
		yourself.
	currentShapes add: visibleShapes
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderPlotsAndTicksIn: canvas [
	currentShapes := OrderedCollection new.
	self renderPlots.
	self renderTicks.
	canvas addAll: currentShapes
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderTicks [
	self renderYAxis.
	self renderXAxis
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderXAxis [
	| horizontalTick tickShapes newPlot scale |
	horizontalTick := chart horizontalTick.
	horizontalTick ifNil: [ ^ self ].
	"should be a copy to not lose created shapes from original horizontal tick"
	scale := horizontalTick xScale.
	"scale inspect."
	newPlot := chart copy.
	newPlot
		minValueX: (scale invert: visibleRectangle origin x);
		maxValueX: (scale invert: visibleRectangle corner x).

	horizontalTick := horizontalTick copy.
	horizontalTick xScale: nil.
	horizontalTick chart: newPlot.

	tickShapes := RSGroup new.

	horizontalTick
		beforeRenderingIn: newPlot;
		renderIn: tickShapes.

	currentShapes addAll: tickShapes
]

{ #category : 'rendering' }
RSZoomTickDecoration >> renderYAxis [
	| verticalTick tickShapes ymin ymax scale |
	verticalTick := chart verticalTick.
	verticalTick ifNil: [ ^ self ].

	ymin := visibleRectangle origin y.
	ymax := visibleRectangle corner y.
	tickShapes := verticalTick createdShapes
		select: [ :s |s position y between: ymin and: ymax ]
		thenCollect: [:s | | copy |
			copy := s copy.
			s isLine ifFalse: [ copy matrix: s matrix copy ].
			copy ].
	scale := self boxScale.
	tickShapes do: [ :each | each translateTo: each position x @ (scale invert: each position) y ].
	currentShapes addAll: tickShapes
]

{ #category : 'events' }
RSZoomTickDecoration >> resetZoom: evt [
	| canvas |
	canvas := evt canvas.
	visibleRectangle := self chart spine encompassingRectangle.
	currentShapes do: #remove.
	currentShapes := self chartElements flatCollect: [ :element | element createdShapes ifNil: [#()] ].
	canvas addAll: currentShapes.
	resetLabel pushFront.
	evt signalUpdate
]

{ #category : 'events' }
RSZoomTickDecoration >> updateSelection: evt [
	visibleRectangle := self computeVisibleRectangle: evt shape encompassingRectangle.
	currentShapes do: #remove.
	self renderPlotsAndTicksIn: evt canvas.
	resetLabel pushFront
]
