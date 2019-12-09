"
I use the RSShapeBuilder
"
Class {
	#name : #RSShapeExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #shapes }
RSShapeExamples >> example01BasicShape [
	<script: 'self new example01BasicShape open'>

	| canvas shapes |
	canvas := RSCanvas new.

	shapes := (1 to: 20) collect: [ :m |
		RSBox new
			size: m;
			position: (1 to: m) sum asPoint - 150;
			color: (m even
				ifTrue: Color red
				ifFalse: Color blue);
			yourself
		 ].
	canvas addAll: shapes.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example02BasicEdge [
	<script: 'self new example02BasicEdge open'>

	| canvas box |
	canvas := RSCanvas new.
	
	box := RSBox new
		size: 100;
		draggable;
		position: -100@150;
		yourself.
	canvas add: box.
	canvas add: (
		RSLine new
			from: box;
			to: 0@0;
			color: Color red;
			yourself).
	canvas add: (
		RSLine new
			startPoint: 100@100;
			endPoint: 150@150;
			yourself).

	^ canvas
	



]

{ #category : #lines }
RSShapeExamples >> example03LinePath [
	<script: 'self new example03LinePath open'>

	| canvas shapes form paint line path |
	canvas := RSCanvas new.
	form := self iconNamed: #remote.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	shapes := #(-1 1 ) collect: [ :m |
		RSBox new
			size: form extent x;
			paint: paint;
			position: m * 50 asPoint;
			draggable;
			yourself
		].
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
	line := [:m | RSSVGPathLine new
		borderColor: (m alpha: 0.4);
		svgPath: path;
		width: 4;
		capRound;
		yourself].
	canvas add: ((line value: Color red)
		from: shapes first;
		to: shapes second).
	canvas add: ((line value: Color blue)
		from: shapes second;
		to: shapes first).
	canvas addAll: shapes.
	canvas camera scale: 1.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example04LineDashes [
	<script: 'self new example04LineDashes open'>

	| canvas dashes |
	canvas := RSCanvas new.
	
	dashes := #(
		#()			"no dashes no gaps"
		#(4) 			"Dashes and gaps of the same size"
		#(4 1)		"Dashes and gaps of different sizes"
		#(4 1 2) 	"Dashes and gaps of various sizes with an odd number of values"
		#(4 1 2 3)	"Dashes and gaps of various sizes with an even number of values"
		) doWithIndex: [ :array :k |
		canvas add: (RSLine new
			dashArray: array;
			from: -15@ (k*2);
			to: 15 @(k*2);
			yourself) ] .
	canvas camera 
		scale: 10;
		position: 0@5.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example05CapStyles [
	<script: 'self new example05CapStyles open'>

	| canvas dot styles ann |
	canvas := RSCanvas new.
	dot := [ :position | 
		RSEllipse new
			color: Color darkGray;
			position: position;
			radius: 5;
			yourself
	].
	styles := #('capButt' 'capRound' 'capSquare').
	styles doWithIndex: [ :style :i| 
		| d1 d2 line |
		d1 := dot value: -100@(i*30).
		d2 := dot value: 100@(i*30).
		line := RSLine new
			width: 20;
			color: Color lightGray;
			from: d1;
			to: d2;
			yourself.
		line perform: style asSymbol.
		canvas add: line; add: d1; add: d2.
		 ].
	canvas nodes first @ RSDraggable.
	ann := canvas nodes first announcer.
	canvas nodes do: [ :s | s announcer: ann ].
	^ canvas
	
]

{ #category : #lines }
RSShapeExamples >> example06JoinStyles [
	<script: 'self new example06JoinStyles'>

	| canvas line path styles |
	canvas := RSCanvas new.
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
	
	styles := #('joinMiter' 'joinRound' 'joinBevel').
	styles doWithIndex: [ :style :i|
		line := RSSVGPathLine new 
			svgPath: path;
			borderColor: Color gray;
			draggable;
			width: 25;
			from: ((i-2) * 80)@0;
			to: (((i-2) * 80) + 50)@0;
			perform: style asSymbol;
			yourself.
		canvas add: line.
		.
	].
	
	canvas open
	
]

{ #category : #normalizer }
RSShapeExamples >> example07NormalizeColor [
	<script: 'self new example07NormalizeColor open'>
	| canvas shapes |
	canvas := RSCanvas new.

	shapes := Collection withAllSubclasses collect: [ :cls |
		RSBox new
			model: cls;
			draggable;
			"size: cls numberOfMethods;"
			popup;
			yourself ].
	RSNormalizer color
		shapes: shapes;
		normalize: #numberOfMethods.
	RSNormalizer size
		scale: TSScale sqrt;
		shapes: shapes;
		normalize: #numberOfMethods.

	canvas addAll: shapes.
	RSGridLayout on: shapes.

	canvas camera position: canvas shapes encompassingRectangle center.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit; signalUpdate ].
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example08Labels [
	<script: 'self new example08Labels open'>
	| canvas sb shapes random |
	canvas := RSCanvas new.
	random := Random new.
	sb := RSShapeBuilder label.
	sb interactionDo: #draggable.
	shapes := Collection withAllSubclasses collect: [ :cls |
		RSLabel new
			draggable;
			text: cls;
			model: cls;
			translateTo: (random rsNext: 300) @ (random rsNext: 300);
			yourself ].

	canvas addAll: shapes.
	RSNormalizer fontSize
		shapes: shapes;
		to: 30;
		normalize: #numberOfMethods.
	RSNormalizer color
		shapes: shapes;
		normalize: #numberOfMethods.

	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example09Polyline [
	<script: 'self new example09Polyline open'>
	| canvas box box1 line box2 |
	canvas := RSCanvas new.
	box := [ RSBox new 
		size: 100;
		draggable;
		yourself ].
	box1 := box value.
	box1 translateBy: 150@150.
	box2 := box value.
	box2 translateBy: -200@200.
	canvas add: box1; add: box2.
	line := RSPolyline new
		color: Color red;
		controlPointsController:  { box1. 0@0. [ box1 position x@ box2 position y ]. box2 }.
	canvas add: line.
	^ canvas
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
	border := RSBorder new.
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
	view @ RSCanvasController.
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
			group := RSGroup new.
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
	v @ RSCanvasController.
	v when: RSExtentChangedEvent do: [ v zoomToFit ].
	v open setLabel: 'Collection withAllSubclasses'
]

{ #category : #shapes }
RSShapeExamples >> example12Polygons [
	<script: 'self new example12Polygons'>
	| view color border |
	view := RSView new.
	color:= RSGradientPalette gradient21.
	border := RSBorder new paint: Color black; width: 2.
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
	view when: RSExtentChangedEvent do: [ view zoomToFit ].
	view @ RSCanvasController.
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
		border: (RSBorder new width: 20; joinRound; paint: paint);
		extent: 200@100.
	view add: triangle element.
	box := RSShapeBuilder box
		color: paint;
		extent: 120@200;
		cornerRadius: (RSCornerRadius new bottom: 20).
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
	view when: RSExtentChangedEvent do: [ view zoomToFit ].
	view @ RSCanvasController.
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
		border: (RSBorder new color: Color red; width: 3);
		size: 20; element.
	line := RSSingleEdgeBuilder line
		markerEnd: (RSMarker new shape: arrow; offsetRatio: 0.5; offset: 10); 
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
	<script: 'self new example15BimetricLine open'>
	| canvas s1 s2 l |
	canvas := RSCanvas new.
	s1 := RSBox new
		color: Color blue;
		draggable;
		size: 100;
		yourself.
	s2 := RSBox new
		translateTo: 400@0;
		draggable;
		size: 100;
		yourself.
	l := RSBimetricLine new
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: s1;
		to: s2;
		yourself.
	canvas addAll: { s1. s2. l}.
	canvas @ RSCanvasController. 
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example16Bezier [
	<script: 'self new example16Bezier'>
	| v box e1 e2 l |
	v := RSView new.
	v addShape: (RSBezier new
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
		border: RSBorder new;
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
	v @ RSCanvasController.
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
		withBorder;
		shapes: [ | labels |
			labels := RSShapeBuilder label
				elementsOn: { 'Circle = classes, size = number of methods; gray links = inheritance;'.
				'blue links = dependencies; layout = force based layout on the inheritance links' }.
			RSVerticalLineLayout on: labels.
			labels. ];
		padding: 10.
	legend := composite element.
	RSLocation new
		below;
		offset: 10;
		move: legend on: v elements.
	v add: legend.
	v @ RSCanvasController.
	v open.
]

{ #category : #shapes }
RSShapeExamples >> example19Bitmap [
	<script: 'self new example19Bitmap'>
	| v elements icons |
	icons := Smalltalk ui icons icons associations sorted: [:a :b | a key < b key].

	v := RSView new.
	elements := RSShapeBuilder bitmap
		form: #value;
		interactionDo: [ :i | i popupText: #key ];
		when: RSMouseClick do: [:m | [   
			Clipboard clipboardText: m key.
			self inform: 'Copied icon name' ]];
		elementsOn: icons.
	v addAll: elements.
	RSGridLayout on: elements.
	v @ RSCanvasController.
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
	v @ RSCanvasController.
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
			RSGroup with: (RSShapeBuilder label elementOn: nb)
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

	v @ RSCanvasController.
	v open
]

{ #category : #lines }
RSShapeExamples >> example21SpockLizard [
	<script: 'self new example21SpockLizard'>
	| this v radius paint arrow svg circle hand shape relations color lb |
	this := RSAnimationExamples new.
	v := RSView new.
	radius := 1500.
	paint := LinearGradientPaint fromArray: {(0 -> 'E0BA82'). (1 -> 'F4DFA5')}.
	paint start: -900 @ 900; stop: 900 @ -900.
	v addShape: (RSEllipse new
		noPaint;
		border: (RSBorder new width: 300; paint: paint);
		radius: 1500).
	arrow := RSShapeBuilder triangle
		extent: 380 @ 200;
		color: (Color colorFrom: '36C5B8').
	1 to: 5 do: [ :i | 
		| angle a |
		angle := i * 360 / 5 + 45.
		v addShape: (RSPieSlice new
			color: '36C5B8';
			innerRadius: 1350;
			externalRadius: 1650;
			alphaAngle: angle;
			betaAngle: (angle := angle + 15)).
		a := arrow element.
		a matrix rotateByDegrees: angle negated.
		angle := (angle + 3) degreesToRadians.
		a position: angle cos @ angle sin negated * radius.
		v addShape: a shape ].
	svg := RSShapeBuilder svgPath
		svgPath: [ :sel | this perform: sel asSymbol ].
	shape := RSShapeBuilder composite
		popup;
		draggable;
		onElement;
		if: [ :e | e index = 5 ] then: [ :s | s scaleBy: 2 ];
		shapes: [ :e | 
			circle := RSEllipse new color: Color white.
			hand := svg elementOn: e model index: e index.
			circle
				position: hand position;
				size: (hand extent x max: hand extent y).
			RSGroup with: circle with: hand ];
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
	lb := RSLegend new.
	lb defaultLabel fontSize: 50.
	lb view: v.
	lb shape 
		border: RSBorder new;
		padding: 50.
	lb
		text:
			'... It''s very simple. Scissors cuts paper, paper covers rock, rock crushes lizard, lizard poisons Spock, Spock smashes scissors, '.
	lb
		text:
			'scissors decapitates lizard, lizard eats paper, paper disproves Spock, Spock vaporizes rock, and, as it always has, rock crushes scissors'.
	lb build.
	v @ RSCanvasController.
	v open
]

{ #category : #lines }
RSShapeExamples >> example22ScaleEvents [
	<script: 'self new example22ScaleEvents'>
	| v sb label box |
	v := RSView new.
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		border: RSBorder new;
		cornerRadius: (RSCornerRadius new right: 10);
		extent: [ :lb | lb extent + 5 ].
	sb := RSShapeBuilder composite
		interactionDo: #draggable;
		shapes: [ :m | | l |
			l := label elementOn: m.
			RSGroup with: (box elementOn: l) with: l].
	v addAll: (sb elementsOn: ArrayedCollection withAllSubclasses).
	v @ RSCanvasController.
	RSEdgeBuilder orthoHorizontal
		markerEnd: (RSMarker new 
			offset: 6;
			shape: (RSShapeBuilder triangle 
				color: Color red;
				size: 10;
				element));
		attachPoint: RSHorizontalAttachPoint new; 
		border: (RSBorder new);
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

{ #category : #shapes }
RSShapeExamples >> example24Highlightable [
	<script: 'self new example24Highlightable'>
	| canvas shapes interaction |
	canvas := RSCanvas new.
	interaction := RSLabeled new.
	interaction shapeBuilder: [:str | 
		| g title box |
		title := RSLabel new text: str; yourself.
		box := RSBox new
			withBorder;
			extent: title textWidth @ 3;
			yourself.
		g := { title. box }.
		RSVerticalLineLayout new alignCenter; gapSize: 0; on: g.
		g asGroup asShape].
	interaction highlightable.
	interaction target: [ :e | e shapes first ].
	shapes := #('Hello' 'World') collect: [:str | 
		RSEllipse new
			color: Color blue;
			model: str;
			addInteraction: interaction;
			draggable;
			size: 20;
			yourself ].
	canvas addAll: shapes.
	RSHorizontalLineLayout on: shapes.
	canvas @ RSCanvasController.
	canvas open.
]

{ #category : #shapes }
RSShapeExamples >> example25BimetricLineOnLargeExample [
	<script: 'self new example25BimetricLineOnLargeExample open'>
	| packagesRegExp packages l packageElements high canvas |
	packagesRegExp := { 'Calypso*' }.
	
	packages := packagesRegExp flatCollect: [ :regExp | 
		RPackageOrganizer default packages 
			select: [ :p | regExp match: p packageName ] ].
		
	l := RSLabeled new text: [ :model | model packageName ].
	packageElements  := packages collect: [ :pkg | | shapes |
		shapes := pkg definedClasses collect: [ :cls |
			RSBox new
				color: Color black;
				size: cls numberOfMethods sqrt;
				yourself
			 ].
		RSGridLayout on: shapes.
		RSComposite new
			color: Color blue trans;
			model: pkg;
			addInteraction: l;
			draggable;
			shapes: shapes;
			padding: 5;
			yourself ] as: RSGroup.
	high := RSHighlightable new.
	high withEdges.
	high highlightColor: Color red trans.							
	packageElements @ high.						
	canvas := RSCanvas new.
	canvas addAll: packageElements.

	RSEdgeBuilder bimetricLine
		canvas: canvas;
		objects: packages;
		noBorder;
		widthFrom:[ :edge | (edge key numberOfDependenciesToward: edge value) sqrt * 4 ];
		widthTo:[ :edge | (edge value numberOfDependenciesToward: edge key) sqrt * 4 ];
		paint: Color blue trans;
		withBorderAttachPoint;
		connectFrom: #yourself toAll: #dependentPackages.
	RSWeightedCircleLayout new initialRadius: 300; on: packageElements.
	canvas @ RSCanvasController.
	^ canvas
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
	<script: 'self new example27MultilineLabelBasic open'>
	| canvas shapeBuilder |
	canvas := RSCanvas new.
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		font: 20;
		italic.
	canvas add:(shapeBuilder shapeFor: '"tu est loin, 
très loin de tous ces regards vicieux 
qui s''alimentent de ta lumière"').
	canvas nodes when: RSMouseClick do: [ :evt | canvas nodes last inspect ].
	canvas showEncompassingRectangles.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example28MultilineLabel [
	<script: 'self new example28MultilineLabel open'>
	| canvas shapes |
	canvas := RSCanvas new.
	shapes := RSShape withAllSubclasses collect: [ :cls | 
		| methods |
		methods := cls methods collect: [ :met | 
			RSBox new
				model: met;
				size: 20;
				popup;
				when: RSMouseClick do: [ :evt | evt shape inspect ];
				yourself
			 ].
		RSGridLayout on: methods.
		RSComposite new
			model: cls;
			shapes: methods;
			padding: 10;
			color: (Color purple alpha: 0.3 );
			draggable; 
			popup;
			yourself ].
	RSEdgeBuilder orthoVertical
		withVerticalAttachPoint;
		canvas: canvas;
		shapes: shapes;
		connectFrom: #superclass.
	canvas addAll: shapes.
	RSTreeLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas.
]

{ #category : #shapes }
RSShapeExamples >> example29AntAnimation [
	<script: 'self new example29AntAnimation open setLabel: ''Move mouse on one box'''>
	| canvas shapes labelInt highInt popupMethod |
	canvas := RSCanvas new.
	labelInt := RSLabeled new.
	labelInt shapeBuilder: [ :model |
		 RSLabel new 
			color: Color white; 
			text: model;
			yourself ].
	highInt := RSHighlightable new setupAntAnimation yourself.
	popupMethod := RSPopup text: #selector.
	shapes := String withAllSubclasses collect: [ :cls | | methods |
		methods := cls methods collect: [ :met |
			RSBox new
				color: Color green;
				model: met;
				addInteraction: popupMethod;
				size: met linesOfCode ].
		RSGridLayout on: methods.
		RSComposite new
			color: Color white trans;
			model: cls;
			shapes: methods;
			padding: 10;
			popup;
			draggable;
			addInteraction: labelInt;
			addInteraction: highInt;
			yourself ].
	canvas color: PharoDarkTheme new backgroundColor.
	
	canvas addAll: shapes.
	
	RSEdgeBuilder line
		color: Color white;
		withVerticalAttachPoint;
		canvas: canvas;
		connectFrom: #superclass.
	canvas edges pushBack.
	RSTreeLayout new 
		verticalGap: 100;
		on: shapes.
	canvas @ RSCanvasController.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example30EdgesToChildren [
	<script: 'self new example30EdgesToChildren'>
	
	| view color ellipse shape parent1 parent2 edge |
	view := RSView new.
	color := TSScale category20b.
	ellipse := RSShapeBuilder ellipse
		color: color;
		size: 20.
	shape := RSShapeBuilder composite
		shapes: [ :m | ellipse elementsOn: { m+2 } ];
		color: color;
		draggable;
		padding: (Margin 
			left: 100
			right: 10
			top: 100
			bottom: 10).
	parent1 := shape elementOn: 1.
	parent2 := shape elementOn: 2.
	parent1 translateTo: 100@100.
	edge := RSSingleEdgeBuilder line
		width: 2;
		color: Color red;
		from: parent1 children first;
		to: parent2 children first;
		edge.
	view newAnimation
		repeat;
		from: 0;
		to: 360;
		onStepDo: [:t | | p |
			p := parent1 position.
			parent1 matrix
				loadIdentity;
				rotateByDegrees: t.
			parent1 translateTo: p].
	view add: parent1; add: parent2; add: edge.
	view open


]

{ #category : #shapes }
RSShapeExamples >> example31BasicGrapher [
	<script: 'self new example31BasicGrapher'>
	| classes v line es |
	classes := Collection withAllSubclasses.
	
	v := RSView new.
	line := RSSingleEdgeBuilder polyline 
		width: 2;
		controlPoints: { 0@ -600. 0@0. 600@0 };
		markerStartEnd: (RSShapeBuilder triangle
			size: 20;
			color: Color black;
			element);
		edgeOn: nil.
	es := RSShapeBuilder circle
		interactionDo: [ :i | i popup; browseable ];
		withBorder;
		color: RSColorPalette sequential orrd9;
		elementsOn: classes.
	v addAll: es.
	v add: line.
	RSNormalizer size
		from: 5;
		to: 20;
		elements: es;
		normalize: [ :cls | cls instVarNames size ].
	
	RSNormalizer position
		from: 0@0;
		to: 600@ -600;
		elements: es;
		normalize: [ :cls | cls numberOfMethods @ cls linesOfCode ].
	v @ RSCanvasController.
	v open
]

{ #category : #shapes }
RSShapeExamples >> example32RSLabeledOnComposite [
	<script: 'self new example32RSLabeledOnComposite open'>
	| canvas shapes labeled |
	canvas := RSCanvas new.
	labeled := RSLabeled new.
	labeled location middle.
	shapes := (1 to: 20) collect: [:n| 
		RSBox new
			withBorder;
			model: n;
			@ labeled;
			popup; draggable;
			size: 50;
			yourself
		] as: RSGroup.
	RSGridLayout on: shapes.
	canvas add: shapes asShape.
	shapes translateBy: 0@0.
	canvas nodes first
		scaleBy: 0.5@ 1;
		rotateByDegrees: 45.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example33ColorScaling [
	<script: 'self new example33ColorScaling'>
	| c classes scale |
	c := RSCanvas new.

	classes := RSObject withAllSubclasses.

	scale := TSScale linear
		domain: { (classes collect: #numberOfMethods) min . (classes collect: #numberOfMethods) max};
		range: { 'red'. 'blue' }.

	classes do: [ :cls |
		| b |
		b := RSEllipse new.
		b size: cls numberOfMethods.
		b color: (scale scale: cls numberOfMethods).
		b model: cls.
		b @ RSPopup.
		c add: b ].

	RSFlowLayout on: c shapes.

	c @ RSCanvasController.
	c open
]

{ #category : #shapes }
RSShapeExamples >> example34MorphicPopup [
	<script: 'self new example34MorphicPopup open'>
	| c |
	c := RSCanvas new.
	Collection withAllSubclassesDo: [ :cls |
		c add: (RSBox new
			model: cls;
			size: 10;
			yourself) ].
	RSGridLayout on: c nodes.
	c @ RSCanvasController.
	c nodes @ (RSMorphicPopup new
		morphBuilder: [:model | ('Class: ', model asString) asTextMorph ]) .
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example35RoassalPackages [
	<script: 'self new example35RoassalPackages open'>
	| packagesRegExp packages canvas color labeled boxes layout |
	packagesRegExp := { 'Roassal3*' }.
	    
	packages := packagesRegExp flatCollect: [ :regExp | 
	    RPackageOrganizer default packages 
	        select: [ :p | regExp match: p packageName ] ].
	    
	canvas := RSCanvas new.
	color := TSScale category20c.
	labeled := RSLabeled new.
	labeled shapeBuilder textBlock: #name.
	boxes := packages collect: [ :pkg |
	    RSBox new
	        model: pkg;
	        color: (color scale: pkg);
	        @labeled;
	        size: pkg linesOfCode sqrt;
	        yourself  ].
	canvas addAll: boxes.
	canvas nodes @ (RSPopup text: #name).
	RSEdgeBuilder arrowedLine
	    withBorderAttachPoint;
	    canvas: canvas;
	    connectFrom: #yourself toAll: #dependentPackages.

	layout := RSForceBasedLayout new
	    nodes: boxes;
	    length: 300;
	    charge: -300;
	    edges: canvas edges;
	    start;
	    yourself.
	canvas nodes @ (RSDraggableForce new layout: layout).
	canvas @ (RSForceLayoutStepping new layout: layout).
	canvas @ RSCanvasController.
	^ canvas
]
