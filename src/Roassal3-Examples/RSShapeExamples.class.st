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
	line := RSSingleEdgeBuilder line 
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
	"1800 ellipses"
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

{ #category : #shapes }
RSShapeExamples >> example11ClassTree [
	<script: 'self new example11ClassTree'>
	| v shape label shapeWithTitle elements |
	v := RSView new.
	"v showEncompassingRectangles."
	shape := RSShapeBuilder composite
		color: (Color lightGray alpha: 0.4);
		shapes: [ :cls | 
			| group |
			group := RSShapeBuilder box
				interactionDo: [ :i | i popupText: #selector ];
				size: #linesOfCode;
				elementsOn: cls methods.
			RSGridLayout on: group.
			group ];
		onElement;
		extent: [ :anElement | anElement extent + (10 @ 10) ].
	label := RSShapeBuilder label.
	shapeWithTitle := RSShapeBuilder composite
		interactionDo: [ :i | 
			i
				draggable;
				popup ];
		shapes: [ :cls | 
			| group lb s |
			group := TSGroup new.
			s := shape elementOn: cls.
			lb := label elementOn: cls.
			group add: lb.
			group add: s.
			RSVerticalLineLayout new alignCenter on: group.
			group ].
	elements := shapeWithTitle elementsOn: Collection withAllSubclasses.
	v addAll: elements.
	RSEdgeBuilder line
		view: v;
		objects: Collection withAllSubclasses;
		connectFrom: #superclass.
	v edges pushBack.
	RSTreeLayout on: elements.
	v @ RSControlsView.
	v when: TSExtentChangedEvent do: [ v zoomToFit ].
	v open setLabel: 'Collection withAllSubclasses'
]

{ #category : #shapes }
RSShapeExamples >> example12Polygons [
	<script: 'self new example12Polygons'>
	| view color border |
	view := RSView new.
	color:= TSGradientPalette gradient21.
	border := TSBorder new paint: Color black; width: 2.
	#('diamond' 'square' 'heptagon' 'hexagon' 
	'octagon' 'pentagon' 'rhomboid' 'star'
	'triangle' 'vee' 'cross' 'arrow'
	"not polygons" 'box' 'circle') do: [ :selector| 
		| shape |
		shape := (RSShapeBuilder perform: selector asSymbol)
			size: 100;
			interactionDo: #popup;
			color: [:e | | grad |
				grad := color scale: e.
				grad start: -50 asPoint; stop: 50 asPoint.
				grad];
			border: border.
		view add: (shape elementOn: selector)
		 ].
	"view showEncompassingRectangles.
	view animation repeat;
		scale: (TSScale linear domain: {0. 0.5. 1}; range:{ 100. 150. 100} );
		onStepDo: [ :t | 
			view elements do: [ :e | e size: t ] ]."
	RSGridLayout new gapSize: 50; on: view elements.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view @ RSControlsView.
	view open setLabel: 'Polygon shapes'.
]

{ #category : #shapes }
RSShapeExamples >> example13Arrow [
	<script: 'self new example13Arrow'>
	| view triangle box label labels paint |
	view := RSView new.
	   
	paint := LinearGradientPaint new
		colorRamp:
			{(0 -> (Color colorFrom: 'CC2A49')).
			(0.25 -> (Color colorFrom: 'F99E4C')).
			(0.50 -> (Color colorFrom: 'F36F38')).
			(0.75 -> (Color colorFrom: 'EF4648')).
			(1 -> (Color colorFrom: '582841'))};
		start: -100 asPoint;
		stop: 100 asPoint.
	triangle := RSShapeBuilder triangle
		color: paint;
		border: (TSBorder new width: 20; joinRound; paint: paint);
		extent: 200@100.
	view add: triangle element.
	box := RSShapeBuilder box
		color: paint;
		extent: 120@200;
		cornerRadius: (TSCornerRadius new bottom: 20).
	view add: box element.
	view elements second pushBack.
	
	RSVerticalLineLayout new alignCenter; gapSize: -1; on: view elements.
	label := RSShapeBuilder label
		fontSize: 20;
		text: #asUppercase;
		onElement;
		if: [ :e | e index = 3 ] actions: [ :s | s fontSize: 10 ].
	labels := label elementsOn: #('Keep' 'calm' 'and' 'roassal' 'on').
	view addAll: labels.
	RSVerticalLineLayout new alignCenter on: labels.
	labels translateBy: 50@50.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view @ RSControlsView.
	view open setLabel: 'You can do it'.
]

{ #category : #shapes }
RSShapeExamples >> example14Marker [
	<script: 'self new example14Marker'>
	| view  elements line arrow |
	view := RSView new.
	elements := RSShapeBuilder ellipse 
		interactionDo: #draggable;
		size: 100; elementsOn: (1 to: 2).
	
	arrow := RSShapeBuilder triangle 
		color: Color white;
		border: (TSBorder new color: Color red; width: 3);
		size: 20; element.
	line := RSSingleEdgeBuilder line
		markerEnd: (TSMarker new shape: arrow; offsetRatio: 0.5; offset: 10); 
		from: elements first;
		to: elements second;
		edge.

	view addAll: elements.
	view add: line.
	RSFlowLayout on: elements.
	view open
]

{ #category : #shapes }
RSShapeExamples >> example15BimetricLine [
	<script: 'self new example15BimetricLine'>
	| view e1 e2 box l |
	view := RSView new.
	box := RSShapeBuilder box 
		size: 100;
		draggable.
	e1 := box element.
	e1 color: Color blue.
	e2 := box element.
	e2 translateTo: 400@0.
	l := RSSingleEdgeBuilder bimetricLine
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: e1;
		to: e2;
		edge.
	view addAll: { e1. e2. l}.
	view @ RSControlsView. 
	view open
]

{ #category : #shapes }
RSShapeExamples >> example16Bezier [
	<script: 'self new example16Bezier'>
	| v box e1 e2 l |
	v := RSView new.
	v addShape: (TSBezier new
		color: Color red;
		controlPoints:
			{(0 @ 0).
			(100 @ 100).
			(200 @ 0).
			(300 @ 100)}).
	box := RSShapeBuilder box draggable size: 100.
	e1 := box element.
	e1 color: Color blue.
	e1 translateTo: 100 @ -200.
	e2 := box element.
	v
		add: e1;
		add: e2.
	l := RSSingleEdgeBuilder bezier
		withVerticalAttachPoint;
		"paint: Color red trans;"
		from: e1;
		to: e2;
		controlPoints: [ :m | 
			[ :a :b | 
			| mid |
			mid := (a + b) / 2.
			Array
				with: a
				with: a x @ mid y
				with: b x @ mid y
				with: b ] ];
		edge.
	v add: l.
	v open
]

{ #category : #shapes }
RSShapeExamples >> example17Labeled [
	<script: 'self new example17Labeled'>
	| v e1 e2 s l |
	v := RSView new.
	s := RSShapeBuilder ellipse
		border: TSBorder new;
		interactionDo: [:i | i draggable; labeled ];
		size: 20.
	e1 := s elementOn: 'hello'.
	e2 := s elementOn: 'world'.
	e2 translateTo: 60@80.
	l := RSSingleEdgeBuilder arrowedLine 
		interactionDo: [ :i | | label |
			label := i labeled.
			label location  
				inner;
				middle.
			label shape text: 'lining up!' ];
		color: Color red;
		from: e1;
		to: e2;
		edge.
	v add: e1; add: e2; add: l.
	v @ RSControlsView.
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example18ExampleFromMondrian [
	<script: 'self new example18ExampleFromMondrian'>
	| v shape composite legend |
	v := RSView new.
	shape := RSShapeBuilder circle
		draggable;
		popup;
		color: Color red trans.
	v addAll: (shape elementsOn: Collection withAllSubclasses).
	RSNormalizer size
		from: 5;
		to: 50;
		elements: v elements;
		normalize: #numberOfMethods.
	RSEdgeBuilder line
		color: Color lightGray;
		elements: v elements;
		view: v;
		connectFrom: #superclass.
	RSForceBasedLayout on: v elements.
	RSEdgeBuilder linePath
		color: (Color blue alpha: 0.1);
		elements: v elements;
		view: v;
		tension: 0.7;
		bezierLineFollowing: #superclass;
		connectToAll: #dependentClasses.
	
	composite := RSShapeBuilder composite 
		border: (TSBorder new);
		shapes: [ | labels |
			labels := RSShapeBuilder label
				elementsOn: { 'Circle = classes, size = number of methods; gray links = inheritance;'.
				'blue links = dependencies; layout = force based layout on the inheritance links' }.
			RSVerticalLineLayout on: labels.
			labels. ];
		padding: 10.
	legend := composite element.
	RSLocate new
		below;
		padding: 10;
		move: legend on: v elements.
	v add: legend.
	v @ RSControlsView.
	v open.
]
