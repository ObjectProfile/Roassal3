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
		borderColor: [:m | m alpha: 0.4];
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
		borderColor: Color gray;
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
		if: [ :e | e index = 3 ] then: [ :s | s fontSize: 10 ].
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
	RSEdgeBuilder multiBezier
		borderColor: (Color blue alpha: 0.1);
		elements: v elements;
		view: v;
		tension: 0.7;
		following: #superclass;
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
		offset: 10;
		move: legend on: v elements.
	v add: legend.
	v @ RSControlsView.
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example19Bitmap [
	<script: 'self new example19Bitmap'>
	| v elements |
	v := RSView new.
	elements := RSShapeBuilder bitmap
		form: #value;
		interactionDo: [ :i | i popupText: #key ];
		when: TSMouseClick do: [:m | [   
			Clipboard clipboardText: m key.
			self inform: 'Copied icon name' ]];
		elementsOn: Smalltalk ui icons icons associations.
	v addAll: elements.
	RSGridLayout on: elements.
	v @ RSControlsView.
	v open
]

{ #category : #shapes }
RSShapeExamples >> example20Highlightable [
	<script: 'self new example20Highlightable'>
	| v es s |
	v := RSView new.
	s := RSShapeBuilder ellipse
		color: Color blue;
		interactionDo: [:i | i draggable; labeledHighlightable];
		size: 20.
	es := s elementsOn: #('Hello' 'World').
	v addAll: es.
	RSHorizontalLineLayout on: es.
	v @ RSControlsView.
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example21MenuActivableOnElement [
	<script: 'self new example21MenuActivableOnElement'>
	|v boxes |
	v := RSView new.

	boxes := RSShapeBuilder composite
		color: Color blue trans;
		shapes: [ :nb | 
			TSGroup with: (RSShapeBuilder label elementOn: nb)
	 	]; 
		size: 30;
		elementsOn: (1 to: 100).
	v addAll: boxes.
	boxes @ RSHighlightable.
	RSGridLayout on: boxes.
	boxes @ (RSMenuActivable new menuDo: [ :menu :box | 
		menu 
			add: 'Inspect'
			target: box
			selector: #inspect
			argument: #() ]).

	v @ RSControlsView.
	v open
]

{ #category : #lines }
RSShapeExamples >> example21SpockLizard [
	<script: 'self new example21SpockLizard'>
	| this v radius paint arrow svg circle hand shape relations color lb |
	this := RSAnimationExamples new.
	v := RSView new.
	radius := 1500.
	paint := TSGradientPalette linearGradient: {(0 -> 'E0BA82'). (1 -> 'F4DFA5')}.
	paint start: -900 @ 900; stop: 900 @ -900.
	v addShape: (TSEllipse new
		noPaint;
		border: (TSBorder new width: 300; paint: paint);
		radius: 1500).
	arrow := RSShapeBuilder triangle
		extent: 380 @ 200;
		color: (Color colorFrom: '36C5B8').
	1 to: 5 do: [ :i | 
		| angle a |
		angle := i * 360 / 5 + 45.
		v addShape: (TSPieSlice new
			color: '36C5B8';
			innerRadius: 1350;
			externalRadius: 1650;
			alphaAngle: angle;
			betaAngle: (angle := angle + 15)).
		a := arrow element.
		a matrix rotateByDegrees: angle negated.
		angle := (angle + 3) degreesToRadians.
		a position: angle cos @ angle sin negated * radius.
		v addShape: a trachelShape ].
	svg := RSShapeBuilder svgPath
		svgPath: [ :sel | this perform: sel asSymbol ].
	shape := RSShapeBuilder composite
		popup;
		draggable;
		onElement;
		if: [ :e | e index = 5 ] then: [ :s | s scaleBy: 2 ];
		shapes: [ :e | 
			circle := TSEllipse new color: Color white.
			hand := svg elementOn: e model index: e index.
			circle
				position: hand position;
				size: (hand extent x max: hand extent y).
			TSGroup with: circle with: hand ];
		position: [ :e | 
			| ang |
			ang := e index * Float twoPi / 5 - Float halfPi.
			ang cos @ ang sin * radius ].
	v
		addAll: (shape elementsOn: #('paper' 'scissors' 'spock' 'lizard' 'rock')).
	relations := {('scissors' -> 'lizard').
	('lizard' -> 'paper').
	('paper' -> 'spock').
	('spock' -> 'rock').
	('rock' -> 'scissors')}.
	color := TSScale category20c.
	RSEdgeBuilder bezier
		color: color;
		controlPoints: [ :m | 
			[ :a :b | 
			| vec f t |
			vec := b - a.
			f := vec * 0.25 + a.
			t := vec * 0.75 + a.
			Array with: f with: 0 @ 0 with: t ] ];
		markerEnd: [ :m | (arrow element color: (color scale: m)) asMarker offset: -90 ];
		width: 300;
		view: v;
		elements: v elements;
		useAssociations: relations.
	v elements pushFront.
	lb := RSLegendBuilder new.
	lb defLabel fontSize: 50.
	lb view: v.
	lb shape 
		border: TSBorder new;
		padding: 50.
	lb
		text:
			'... It''s very simple. Scissors cuts paper, paper covers rock, rock crushes lizard, lizard poisons Spock, Spock smashes scissors, '.
	lb
		text:
			'scissors decapitates lizard, lizard eats paper, paper disproves Spock, Spock vaporizes rock, and, as it always has, rock crushes scissors'.
	lb build.
	v @ RSControlsView.
	v open
]

{ #category : #lines }
RSShapeExamples >> example22ScaleEvents [
	<script: 'self new example22ScaleEvents'>
	| v sb label box |
	v := RSView new.
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		border: TSBorder new;
		cornerRadius: (TSCornerRadius new right: 10);
		extent: [ :lb | lb extent + 5 ].
	sb := RSShapeBuilder composite
		interactionDo: #draggable;
		shapes: [ :m | | l |
			l := label elementOn: m.
			TSGroup with: (box elementOn: l) with: l].
	v addAll: (sb elementsOn: ArrayedCollection withAllSubclasses).
	v @ RSControlsView.
	RSEdgeBuilder orthoHorizontal
		markerEnd: (TSMarker new 
			offset: 6;
			shape: (RSShapeBuilder triangle 
				color: Color red;
				size: 10;
				element));
		attachPoint: RSHorizontalAttachPoint new; 
		border: (TSBorder new);
		view: v;
		elements: v elements;
		connectFrom: #superclass.
	"v edges @ RSKeepBorderWidthRatio. Not necessary since all edges shares the same border"
	RSKeepBorderWidthRatio reset.
	RSKeepMarkersSizeRatio reset.
	v edges first @ RSKeepBorderWidthRatio. 
	v edges first @ RSKeepMarkersSizeRatio.
	RSHorizontalTreeLayout new on: v elements.
	v open setLabel: 'Horizontal Tree'
]

{ #category : #lines }
RSShapeExamples >> example23LightShapes [
	<script: 'self new example23LightShapes'>
	| v box shape elements lbl update |
	v := RSView new.
	box := RSShapeBuilder box.
	shape := RSShapeBuilder composite
		popup;
		draggable;
		shapes: [ :cls | 
			| g |
			g := box elementsOn: cls methods.
			RSGridLayout on: g.
			g ];
		padding:
			(Margin
				left: 50
				right: 5
				top: 20
				bottom: 5);
		color: Color blue trans.
	elements := shape elementsOn: Collection withAllSubclasses.
	RSGridLayout on: elements.
	v addAll: elements.
	lbl := TSLabel new
		text: '';
		color: Color black;
		isFixed: true.
	v addShape: lbl.
	update := [ 
		lbl text: 'Shapes size: ', v shapes size asString.
		lbl color: Color black.
		lbl position: lbl extent / 2 ].
	v
		when: TSPositionChangedEvent do: update;
		when: TSScaleChangedEvent do: update.
	v @ RSControlsView.
	v @ RSLightShapesView.
	v open
]

{ #category : #shapes }
RSShapeExamples >> example24Highlightable [
	<script: 'self new example24Highlightable'>
	
	| v es s l label boxShape composite |
	v := RSView new.
	l := RSLabeled new.
	label := RSShapeBuilder label.
	boxShape := RSShapeBuilder box
		border: TSBorder new.
	composite := RSShapeBuilder composite shapes: [ :m |
		| g title box |
		g := TSGroup new.
		title := label elementOn: m.
		box := boxShape elementOn: m.
		box extent: title textWidth  @ 3.
		g add: title; add: box. 
		RSVerticalLineLayout new alignCenter; gapSize: 0; on: g.
		g ].
	l shape: composite.
	l highlightable.
	l target: [ :e | e shapes first ].
	s := RSShapeBuilder ellipse
		color: Color blue;
		addInteraction: l;
		interactionDo: [:i | i draggable];
		size: 20.
	es := s elementsOn: #('Hello' 'World').
	v addAll: es.
	RSHorizontalLineLayout on: es.
	v @ RSControlsView.
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example25BimetricLineOnLargeExample [
	<script: 'self new example25BimetricLineOnLargeExample'>
| packagesRegExp packages l packageElements high v |
packagesRegExp := { 'Calypso*' }.

packages := packagesRegExp flatCollect: [ :regExp | RPackageOrganizer default packages select: [ :p | regExp match: p packageName ] ].

l := RSLabeled new text: [ :model | model packageName ].
packageElements := RSShapeBuilder composite
							color: Color blue trans;
							addInteraction: l;
							draggable;
							shapes: [ :pak |
								| g lbl |
								g := RSShapeBuilder box
									size: [ :cls | cls numberOfMethods sqrt ];
									elementsOn: pak definedClasses.
								RSGridLayout on: g.
								g
							]; 
							padding: 5;
							elementsOn: packages.
high := RSHighlightable new.
high withEdges.
high highlightShape color: Color red trans.							
packageElements @ high.						
v := RSView new.
v addAll: packageElements.

RSEdgeBuilder bimetricLine
		view: v;
		objects: packages;
		widthFrom:
				[ :edge | (edge key model numberOfDependenciesToward: edge value model) sqrt * 10 ];
		widthTo:
				[ :edge | (edge value model numberOfDependenciesToward: edge key model) sqrt * 10 ];
		paint: Color blue trans;
		border: nil;
		withBorderAttachPoint;
		connectFrom: #yourself toAll: #dependentPackages.
		
		
RSWeightedCircleLayout new initialRadius: 300; on: packageElements.
v @ RSControlsView.

v open			
]

{ #category : #shapes }
RSShapeExamples >> example26AnimatedPopup [
	<script: 'self new example26AnimatedPopup'>
	| v i s b |
	v := RSView new.
	i := RSAnimatedPopup new.
		
	s := RSShapeBuilder box
		size: 100;
		addInteraction: i;
		translateTo: 100 asPoint;
		isFixed: true.
	b := s elementOn: 'Fixed'.
	v add: b.
	b := s elementOn: 'Not Fixed'.
	b color: Color red.
	b isFixed: false.
	v add: b.
	
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example27MultilineLabelBasic [
	<script: 'self new example27MultilineLabelBasic'>
	| v shape |
	v := RSView new.
	shape := RSShapeBuilder multiline
		font: 20;
		italic.
	v add:(shape elementOn: '"tu est loin, 
très loin de tous ces regards vicieux 
qui s''alimentent de ta lumière"').
	v elements last when: TSMouseClick do: [ :evt | v elements last inspect ].
	v showEncompassingRectangles.
	v open setLabel: 'Multiline'
]

{ #category : #shapes }
RSShapeExamples >> example28MultilineLabel [
	<script: 'self new example28MultilineLabel'>
	| v shape box elements |
	v := RSView new.
	box := RSShapeBuilder box 
		size: 20;
		interactionDo: [:i | i popup multiline ];
		onMyselfDo: [:m | [:e | 
			e when: TSMouseClick do: [ e inspect ] ]].
	shape := RSShapeBuilder composite shapes: [ :m | 
		| methods |
		methods := box elementsOn: m methods.
		RSGridLayout on: methods.
		methods.
		];
		color: (Color purple alpha: 0.3);
		padding: 10;
		interactionDo: [:i | i draggable; popup ].
	elements := shape elementsOn: TSShape withAllSubclasses.
	RSEdgeBuilder orthoVertical
		withVerticalAttachPoint;
		view: v;
		elements: elements;
		connectFrom: #superclass.
	v addAll: elements.
	RSTreeLayout on: elements.
	v @ RSControlsView.
	v open setLabel: 'Example with multiline labels'.
]

{ #category : #shapes }
RSShapeExamples >> example29AntAnimation [
	<script: 'self new example29AntAnimation'>
	
	| v shape shapeWithTitle elements methodShape models |
	v := RSView new.
	models := String withAllSubclasses.
	v color: Smalltalk ui theme backgroundColor.
	methodShape := RSShapeBuilder box
		color: Color green;
		interactionDo: [ :i | i popupText: #selector ];
		size: #linesOfCode.
	shape := RSShapeBuilder composite
		color: Color white trans;
		interactionDo: [:i | 
			| high label |
			label := RSLabeled new.
			label shape color: Color white.
			high := RSHighlightable new.
			high setupAntAnimation.
			i popupAndDraggable; addInteraction: label; addInteraction: high ];
		shapes: [ :cls | 
			| group |
			group := methodShape elementsOn: cls methods.
			RSGridLayout on: group.
			group ];
		onElement;
		extent: [ :anElement | anElement extent + (10 @ 10) ].
	elements := shape elementsOn: models.
	v addAll: elements.
	
	RSEdgeBuilder line
		color: Color white;
		withVerticalAttachPoint;
		view: v;
		objects: models;
		connectFrom: #superclass.
	v edges pushBack.
	RSTreeLayout new 
		verticalGap: 100;
		on: elements.
	v @ RSControlsView.
	v when: TSExtentChangedEvent do: [ v zoomToFit ].
	v open setLabel: 'Move mouse on one box'
]
