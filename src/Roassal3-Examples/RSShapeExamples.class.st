"
I use the RSShapeBuilder
"
Class {
	#name : #RSShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #shapes }
RSShapeExamples >> example01BasicShape [
	<script: 'self new example01BasicShape'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red ]
			ifFalse: [ Color blue ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	v open
]

{ #category : #lines }
RSShapeExamples >> example02BasicEdge [
	<script: 'self new example02BasicEdge'>

	| v box box1 line |
	v := RSView new.
	box := RSShapeBuilder box
		size: 100;
		interactionDo: [ :i | i draggable ].
	box1 := box element.
	box1 translateBy: 150@150.
	v add: box1.
	line := RSEdgeBuilder line 
		color: Color red.
	v add: (line from: box1; to: 0@0; edge).

	v open
	



]

{ #category : #lines }
RSShapeExamples >> example03LinePath [
	<script: 'self new example03LinePath'>

	| v elements form paint line path |
	v := RSView new.
	form := self iconNamed: #remote.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	elements := RSShapeBuilder box
		size: form extent x;
		paint: paint;
		position: [:m | m * 50 asPoint ];
		interactionDo: #draggable;
		elementsOn: {-1. 1}.
		
	path := [ :a :b | String streamContents: [ :s|
		| point number vector u unit middle middle2 l r |
		number := [ :n | 
			s nextPutAll: n asFloat asString ].
		point := [ :p | 
			number value: p x.
			s space.
			number value: p y.
			s space. ].
		vector := a - b.
		u := vector normal.
		unit := vector / vector r.
	
		1 to: 3 do: [ :i |
			middle := a - (unit * (i+1)* 5).
			middle2 := a - (unit * (i*2)*5).
			l := middle - (u * ((i-1) * 7)).
			r := middle + (u * ((i-0.9) * 7)).
			
			s nextPutAll: 'M'.
			point value: l. 
			s nextPutAll: 'Q '.
			point value: middle2.
			point value: r.
			].
		 ] ].
	line := RSEdgeBuilder linePath
		color: [:m | m alpha: 0.4];
		svgPath: [path];
		width: 4;
		capRound.
	v add: (line 
		from: elements first;
		to: elements second;
		edgeOn: Color red).
	v add: (line 
		from: elements second;
		to: elements first;
		edgeOn: Color blue).
	v addAll: elements.
	v camera scale: 1.
	v open
	
]

{ #category : #lines }
RSShapeExamples >> example04LineDashes [
	<script: 'self new example04LineDashes'>

	| v line |
	v := RSView new.
	line := RSEdgeBuilder line
		width: 1.
	"no dashes no gaps"
	v add: (line from: -15@ 1; to: 15@ 1; edge).
	"Dashes and gaps of the same size"
	line dashArray: { 4 }.
	v add: (line from: -15@ 3; to: 15@ 3; edge).
	"Dashes and gaps of different sizes"
	line dashArray: { 4. 1 }.
	v add: (line from: -15@ 5; to: 15@ 5; edge).
	"Dashes and gaps of various sizes with an odd number of values"
	line dashArray: { 4. 1. 2 }.
	v add: (line from: -15@ 7; to: 15@ 7; edge).
	"Dashes and gaps of various sizes with an even number of values"
	line dashArray: { 4. 1. 2. 3 }.
	v add: (line from: -15@ 9; to: 15@ 9; edge).
	v camera 
		scale: 10;
		position: 0@5.
	v open
	
]

{ #category : #lines }
RSShapeExamples >> example05CapStyles [
	<script: 'self new example05CapStyles'>

	| v line dot d1 d2 ed styles |
	v := RSView new.
	line := RSEdgeBuilder line
		color: Color lightGray;
		width: 20.
	dot := RSShapeBuilder circle
		interactionDo: #draggable;
		color: Color darkGray;
		position: #yourself;
		radius: 5.
	styles := #('capButt' 'capRound' 'capSquare').
	styles doWithIndex: [ :style :i|
		d1 := dot elementOn: -100@(i*30).
		d2 := dot elementOn: 100@(i*30).
		line perform: style asSymbol.
		ed := line from: d1; to: d2; edge.
		v add: ed; add: d1; add: d2.
		 ].
	
	v open
	
]

{ #category : #lines }
RSShapeExamples >> example06JoinStyles [
	<script: 'self new example06JoinStyles'>

	| v line path styles |
	v := RSView new.
	path := [ :a :b| String streamContents: [ :s| 
		| mid number point |
		number := [ :n | 
			s nextPutAll: n asFloat asString ].
		point := [ :p | 
			number value: p x.
			s space.
			number value: p y.
			s space. ].
		
		mid := (a + b)/2 + (0@ -50).
		s nextPutAll: 'M'.
		point value: a.
		s nextPutAll: 'L'.
		point value: mid.
		s nextPutAll: 'L'.
		point value: b.
		 ] ].
	
	line := RSEdgeBuilder linePath
		svgPath: [ path ];
		color: Color lightGray;
		width: 25.
	styles := #('joinMiter' 'joinRound' 'joinBevel').
	styles doWithIndex: [ :style :i|
		line perform: style asSymbol.
		v add: (line
			from: ((i-2) * 80)@0;
			to: (((i-2) * 80) + 50)@0;
			edge).
	].
	
	v open
	
]

{ #category : #normalizer }
RSShapeExamples >> example07NormalizeColor [
	<script: 'self new example07NormalizeColor'>
	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	RSNormalizer color
		elements: elements;
		normalize: #numberOfMethods.

	v addAll: elements.
	RSGridLayout on: elements.

	v camera position: v elements encompassingRectangle center.
	v when: TSExtentChangedEvent do: [ v zoomToFit; signalUpdate ].
	v @ RSControlsView.
	v open
	
]

{ #category : #shapes }
RSShapeExamples >> example08Labels [
	<script: 'self new example08Labels'>
	| v sb elements |
	v := RSView new.
	v @ RSControlsView.
	sb := RSShapeBuilder label.
	sb interactionDo: #draggable.
	sb text: #asString.
	elements := sb elementsOn: Collection withAllSubclasses.
	elements
		do:
			[ :e | e translateTo: (Random new nextInt: 300) @ (Random new nextInt: 300) ].
	v addAll: elements.
	RSNormalizer fontSize
		elements: elements;
		to: 30;
		normalize: #numberOfMethods.
	RSNormalizer color
		elements: elements;
		normalize: #numberOfMethods.
	v zoomToFit.
	v open
]

{ #category : #lines }
RSShapeExamples >> example09Polyline [
	<script: 'self new example09Polyline'>
	| v box box1 line box2 |
	v := RSView new.
	box := RSShapeBuilder box
		size: 100;
		interactionDo: #draggable.
	box1 := box element.
	box1 translateBy: 150@150.
	box2 := box element.
	box2 translateBy: -200@200.
	v add: box1; add: box2.
	line := RSSingleEdgeBuilder polyline 
		color: Color red;
		controlPoints: { box1. 0@0. [ box1 position x@ box2 position y ]. box2 }.
	v add: (line edge).

	v open
	



]

{ #category : #shapes }
RSShapeExamples >> example10Donut [
	<script: 'self new example10Donut'>
	| data shape radius color view border |
	data := 0 to: 358 by: 2.
	view := RSView new.
	radius := TSScale linear
		domain: #(1 10);
		range: #(180 240).
	color := TSScale linear
		domain: #(1 7 10);
		range: #('brown' '4682b4' 'brown').
	border := TSBorder new.
	1 to: 10 do: [ :i |
		shape := RSShapeBuilder circle
			radius: 4.5;
			color: (color scale: i);
			border: border;
			position: [ :a | | d |
				d := a degreesToRadians.
				(radius scale: i) * (d cos @ d sin)
				 ].
		view addAll: (shape elementsOn: data).
		 ].
	view @ RSControlsView.
	view zoomToFit.
	view open.
]
