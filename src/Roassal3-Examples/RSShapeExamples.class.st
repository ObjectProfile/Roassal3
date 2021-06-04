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
	canvas nodes first @ RSDraggableInteraction.
	ann := canvas nodes first announcer.
	canvas nodes do: [ :s | s announcer: ann ].
	^ canvas
	
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
		scale: NSScale sqrt;
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
	| canvas shapes random |
	canvas := RSCanvas new.
	random := Random new.
	
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
		controlPointsController: (
			RSCustomCPController new
				models: { 
					box1. 
					0@0. 
					[ box1 position x@ box2 position y ].
					box2 };
				yourself).
	canvas add: line.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example10Donut [
	<script: 'self new example10Donut open'>
	| data radius color canvas border |
	"1800 ellipses"
	data := 0 to: 358 by: 2.
	canvas := RSCanvas new.
	radius := NSScale linear
		domain: #(1 10);
		range: #(180 240).
	color := NSScale linear
		domain: #(1 7 10);
		range: #('brown' '4682b4' 'brown').
	border := RSBorder new.
	1 to: 10 do: [ :i |
		canvas addAll: (data collect: [ :a | 
			| d |
			d := a degreesToRadians.
			RSEllipse new
				radius: 4.5;
				color: (color scale: i);
				border: border;
				position: (radius scale: i) * (d cos @ d sin);
				yourself ]).
		 ].
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example11ClassTree [
	<script: 'self new example11ClassTree open setLabel: ''Collection withAllSubclasses'''>
	| canvas shapes |
	canvas := RSCanvas new.
	"canvas showEncompassingRectangles."
	shapes := Collection withAllSubclasses collect: [ :cls |
		| group label s methods|
		group := RSGroup new.
		methods := cls methods collect: [ :met|
			RSBox new
				model: met;
				popupText: #selector;
				size: met linesOfCode;
				yourself ].
		RSGridLayout on: methods.
		s := RSComposite new
			color: (Color lightGray alpha: 0.4);
			shapes: methods;
			yourself.
		s extent: s extent + 10.
		label := RSLabel new
			text: cls;
			yourself.
		group add: label; add: s.
		RSVerticalLineLayout new alignCenter on: group.
		RSComposite new
			shapes: group;
			model: cls;
			draggable;
			popup;
			yourself  ].
	canvas addAll: shapes.
	RSLineBuilder line
		canvas: canvas;
		objects: Collection withAllSubclasses;
		connectFrom: #superclass.
	canvas edges pushBack.
	RSTreeLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example12Polygons [
	<script: 'self new example12Polygons open setLabel: ''Polygon shapes'''>
	| canvas color border |
	canvas := RSCanvas new.
	color:= RSGradientPalette gradient21.
	border := RSBorder new paint: Color black; width: 2.
	#('diamond' 'square' 'heptagon' 'hexagon' 
	'octagon' 'pentagon' 'rhomboid' 'star'
	'triangle' 'vee' 'plus' 'arrow'
	"not polygons" 'box' 'circle') do: [ :selector| 
		| shape gradient |
		gradient := color scale: selector.
		gradient
			start: -50 asPoint;
			stop: 50 asPoint.
		shape := (RSShapeFactory perform: selector asSymbol)
			size: 100;
			model: selector;
			popup;
			color: gradient;
			border: border.
		canvas add: shape
		 ].

	RSGridLayout new gapSize: 50; on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example13Arrow [
	<script: 'self new example13Arrow open setLabel: ''You can do it'''>
	| canvas polygon labels paint |
	canvas := RSCanvas new.
	paint := (LinearGradientPaint fromArray:
			{0 -> 'CC2A49'.
			0.25 -> 'F99E4C'.
			0.50 -> 'F36F38'.
			0.75 -> 'EF4648'.
			1 -> '582841'})
		start: -125 asPoint;
		stop: 125 asPoint.
	
	polygon := RSPolygon new
		points: 
			{100@0. 200@100. 
			160@100. 160@ 250.
			40@ 250. 40@100.
			0@ 100
			};
		cornerRadii: 7.77;
		paint: paint;
		yourself.
	canvas add: polygon.
	
	labels := #('Keep' 'calm' 'and' 'roassal' 'on') collectWithIndex: [ :t :index |
		RSLabel new
			fontSize: (index = 3 ifTrue: 10 ifFalse: [ 20 ]);
			bold;
			color: Color white;
			text: t asUppercase;
			yourself
		].
	canvas addAll: labels.
	RSVerticalLineLayout new alignCenter on: labels.
	labels asGroup translateBy: 50@50.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example14Marker [
	<script: 'self new example14Marker open'>
	| canvas  shapes line arrow |
	canvas := RSCanvas new.
	shapes := (1 to: 2) collect: [ :n |
		RSEllipse new
			model: n;
			draggable;
			size: 100;
			yourself ].
	arrow := RSShapeFactory triangle 
		color: Color white;
		border: (RSBorder new color: Color red; width: 3);
		size: 20;
		yourself.
	line := RSLine new
		markerEnd: (RSMarker new 
			shape: arrow; 
			offsetRatio: 0.5; 
			offset: 10;
			yourself); 
		from: shapes first;
		to: shapes second;
		yourself.

	canvas addAll: shapes.
	canvas add: line.
	RSFlowLayout on: shapes.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example16Bezier [
	<script: 'self new example16Bezier open'>
	| canvas box1 box2 line |
	canvas := RSCanvas new.
	canvas addShape: (RSBezier new
		color: Color red;
		controlPoints:
			{(0 @ 0).
			(100 @ 100).
			(200 @ 0).
			(300 @ 100)};
		yourself).
	box1 := RSBox new 
		draggable; 
		size: 100; 
		color: Color blue;
		translateTo: 100@ -200; 
		yourself.
	box2 := RSBox new
		draggable;
		size: 100;
		yourself.
	canvas
		add: box1;
		add: box2.
		
	line := RSBezier new
		withVerticalAttachPoint;
		from: box1;
		controlPointsController: RSVerticalCPAPController new;
		to: box2;
		yourself.
	canvas add: line.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example17Labeled [
	<script: 'self new example17Labeled open'>
	| canvas e1 e2 s line label |
	canvas := RSCanvas new.
	s := [ :m | 
		RSEllipse new
			border: RSBorder new; 
			draggable;
			labeled;
			size: 20;
			model: m;
			yourself].
	e1 := s value: 'hello'.
	e2 := s value: 'world'.
	e2 translateTo: 60@80.
	
	label := RSLabeledInteraction new.
	label location inner; middle.
	label shapeBuilder textBlock: 'lining up!'.
	line := RSShapeFactory arrowedLine
		addInteraction: label;
		color: Color red;
		from: e1;
		to: e2;
		yourself.
	canvas add: e1; add: e2; add: line.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example19Bitmap [
	<script: 'self new example19Bitmap open'>
	| canvas shapes icons |
	icons := Smalltalk ui icons icons associations sorted: [:a :b | a key < b key].
	canvas := RSCanvas new.
	shapes := icons collect: [ :icon|
		RSBitmap new
			form: icon value;
			model: icon;
			popupText: #key;
			when: RSMouseClick do: [ :evt |
				Clipboard clipboardText: evt shape model key.
				self inform: 'Copied icon name' ].  ].
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example20Highlightable [
	<script: 'self new example20Highlightable open'>
	| canvas shapes labeled |
	canvas := RSCanvas new.
	labeled := RSLabeledInteraction new.
	labeled highlightable.
	shapes := #('Hello' 'World') collect: [ :m | 
		RSEllipse new
			color: Color blue;
			draggable; 
			addInteraction: labeled;
			size: 20;
			model: m;
			yourself ].
	canvas addAll: shapes.
	RSHorizontalLineLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example21MenuActivableOnElement [
	<script: 'self new example21MenuActivableOnElement open'>
	| canvas boxes |
	canvas := RSCanvas new.
	boxes := (1 to: 100) collect: [ :n |
		RSComposite new
			color: Color blue translucent;
			shapes: { RSLabel new text: n; yourself };
			size: 30;
			yourself ] as: RSGroup.
	canvas addAll: boxes.
	boxes @ RSHighlightableInteraction red.
	RSGridLayout on: boxes.
	boxes @ (RSMenuActivableInteraction new
		menuDo: [ :menu :box | 
			menu 
				add: 'Inspect'
				target: box
				selector: #inspect
				argument: #() ]).
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example22ScaleEvents [
	<script: 'self new example22ScaleEvents open setLabel: ''Horizontal Tree'''>
	"Zooming preserve the size of the red arrow"
	| canvas |
	canvas := RSCanvas new.
	canvas addAll: (ArrayedCollection withAllSubclasses collect: [:cls |
		| label box | 
		label := RSLabel new
			text: cls;
			yourself.
		box := RSBox new
			withBorder;
			cornerRadius: (RSCornerRadius new right: 10);
			extent: label extent + 5.
		RSComposite new
			draggable;
			model: cls;
			shapes: {box. label};
			yourself]).
	
	canvas @ RSCanvasController.
	RSLineBuilder orthoHorizontal
		markerEnd: (RSMarker new 
			offset: 6;
			shape: (RSShapeFactory triangle 
				color: Color red;
				size: 10;
				yourself));
		attachPoint: RSHorizontalAttachPoint new;
		canvas: canvas;
		shapes: canvas nodes;
		connectFrom: #superclass.

	canvas edges @ RSKeepBorderWidthRatio. 
	canvas edges @ RSKeepMarkersSizeRatio.
	RSHorizontalTreeLayout new on: canvas nodes.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example24Highlightable [
	<script: 'self new example24Highlightable open'>
	| canvas shapes interaction |
	canvas := RSCanvas new.
	interaction := RSLabeledInteraction new.
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
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example26AnimatedPopup [
	<script: 'self new example26AnimatedPopup open'>
	| canvas interaction s box |
	canvas := RSCanvas new.
	interaction := RSAnimatedPopup new.
		
	s := [:model |
		RSBox new
			size: 100;
			model: model;
			addInteraction: interaction;
			translateTo: 100 asPoint;
			isFixed: true;
			yourself.
		].
	box := s value: 'Fixed'.
	canvas add: box.
	
	box := s value: 'Not Fixed'.
	box color: Color red.
	box isFixed: false.
	canvas add: box.
	
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example27MultilineLabelBasic [
	<script: 'self new example27MultilineLabelBasic open'>
	| canvas shapeBuilder text |
	canvas := RSCanvas new.
	text := '"tu est loin, 
très loin de tous    ces regards vicieux 
qui s''alimentent de ta lumière"'.
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: 20;
		italic.
	canvas add:(shapeBuilder shapeFor: text).
	shapeBuilder wrapStrategy: (RSWrapStrategy new wrapMaxWidth: 200).
	canvas add:(shapeBuilder shapeFor: text).
	shapeBuilder wrapStrategy: (RSWrapEllipsisStrategy new wrapMaxWidth: 200).
	canvas add:(shapeBuilder shapeFor: String loremIpsum).
	RSFlowLayout  on: canvas nodes.
	canvas nodes when: RSMouseClick do: [ :evt | evt shape inspect ].
	canvas showEncompassingRectangles.
	
	^ canvas zoomToFit 
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
	RSLineBuilder orthoVertical
		withVerticalAttachPoint;
		canvas: canvas;
		shapes: shapes;
		connectFrom: #superclass.
	canvas addAll: shapes.
	RSTreeLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas.
]

{ #category : #lines }
RSShapeExamples >> example29AntAnimation [
	<script: 'self new example29AntAnimation open setLabel: ''Move mouse on one box'''>
	| canvas shapes labelInt highInt popupMethod |
	canvas := RSCanvas new.
	labelInt := RSLabeledInteraction new.
	labelInt shapeBuilder: [ :model |
		 RSLabel new 
			color: Color white; 
			text: model;
			yourself ].
	highInt := RSHighlightableInteraction withAntAnimation.
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
			color: Color white translucent;
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
	
	RSLineBuilder line
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
	<script: 'self new example30EdgesToChildren open'>
	
	| canvas color shape parent1 parent2 edge |
	canvas := RSCanvas new.
	color := NSScale category20b.

	shape := [ :model | 
		RSComposite new
			color: (color scale: model);
			shapes: { 
				RSEllipse new
					color: (color scale: model + 2);
					size: 20;
					yourself };
			draggable;
			padding: (Margin 
				left: 100
				right: 10
				top: 100
				bottom: 10);
			yourself. ].
	parent1 := shape value: 1.
	parent2 := shape value: 2.
	parent1 translateTo: 100@100.
	edge := RSLine new
		width: 2;
		color: Color red;
		from: parent1 shapes first;
		to: parent2 shapes first;
		yourself.
	canvas newAnimation
		repeat;
		from: 0;
		to: 360;
		onStepDo: [:t | | p |
			p := parent1 position.
			parent1 matrix
				loadIdentity;
				rotateByDegrees: t.
			parent1 translateTo: p].
	canvas add: parent1; add: parent2; add: edge.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example31BasicGrapher [
	<script: 'self new example31BasicGrapher open'>
	| classes canvas line shapes color |
	classes := Collection withAllSubclasses.
	
	canvas := RSCanvas new.
	line := RSPolyline new 
		width: 2;
		controlPoints: { 0@ -600. 0@0. 600@0 };
		markerStartEnd: (RSShapeFactory triangle
			size: 20;
			color: Color black;
			yourself);
		yourself.
	
	color := RSColorPalette sequential orrd9.
	shapes := classes collect: [ :cls |
		RSEllipse new
			model: cls;
			popup;
			browseable;
			withBorder;
			color: (color scale: cls);
			yourself ].
	canvas addAll: shapes.
	canvas add: line.
	RSNormalizer size
		from: 5;
		to: 20;
		shapes: shapes;
		normalize: [ :cls | cls instVarNames size ].
	
	RSNormalizer position
		from: 0@0;
		to: 600@ -600;
		shapes: shapes;
		normalize: [ :cls | cls numberOfMethods @ cls linesOfCode ].
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example32RSLabeledOnComposite [
	<script: 'self new example32RSLabeledOnComposite open'>
	| canvas shapes labeled |
	canvas := RSCanvas new.
	labeled := RSLabeledInteraction new.
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
	<script: 'self new example33ColorScaling open'>
	| c classes scale numberOfMethods |
	c := RSCanvas new.

	classes := RSObject withAllSubclasses.
	numberOfMethods := classes collect: #numberOfMethods.

	scale := NSScale linear
		domain: { numberOfMethods min. numberOfMethods max};
		range: { 'red'. 'blue' }.

	c addAll: (classes collect: [ :cls |
		| b |
		b := RSEllipse new.
		b size: cls linesOfCode sqrt.
		b color: (scale scale: cls numberOfMethods).
		b model: cls.
		b @ RSPopup.
		b ]).

	RSFlowLayout on: c shapes.

	c @ RSCanvasController.
	^ c
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

{ #category : #lines }
RSShapeExamples >> example35Lines [
	<script: 'self new example35Lines open'>
	| c circle box dragMeLabel |
	c := RSCanvas new.
	circle := RSEllipse new
		color: Color green;
		size: 10.
	box := RSBox new
		color: Color red;
		size: 10.
	c
		add: circle;
		add: box.
	dragMeLabel := RSLabel new text: 'Drag me'.
	c add: dragMeLabel.
	RSLocation new
		above;
		center;
		stick: dragMeLabel on: box.
	c
		add:
			(RSLine new
				color: Color veryVeryLightGray;
				from: 0 @ -1000;
				to: 0 @ 1000).
	c
		add:
			(RSLine new
				color: Color veryVeryLightGray;
				from: -1000 @ 0;
				to: 1000 @ 0).
	box translateBy: 50 @ 50.
	box @ RSDraggableInteraction.
	c
		add:
			(RSLine new
				color: Color blue;
				from: box;
				to: circle).
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example36ShapePosition [
	<script: 'self new example36ShapePosition open'>
	| c circle box labelBox dragMeLabel |
	c := RSCanvas new.
	circle := RSEllipse new size: 10.
	box := RSBox new
		color: Color red;
		size: 10.
	c
		add: circle;
		add: box.
	c
		add:
			(RSLine new
				color: Color veryVeryLightGray;
				from: 0 @ -1000;
				to: 0 @ 1000).
	c
		add:
			(RSLine new
				color: Color veryVeryLightGray;
				from: -1000 @ 0;
				to: 1000 @ 0).
	labelBox := RSLabel new text: 'Box'.
	c add: labelBox.
	labelBox setAsFixed.
	labelBox translateBy: 100 @ 50.
	box @ RSDraggableInteraction.
	box
		when: RSMouseDragging
		do: [ :evt | 
			labelBox
				text: 'Box position = ' , evt position asIntegerPoint asString ].
			
	dragMeLabel := RSLabel new text: 'Drag me'.
	c add: dragMeLabel.
	RSLocation new
		above; center;
		stick: dragMeLabel on: box.
	box translateTo: 50 @ 50.
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example37PunchCard [
	<script: 'self new example37PunchCard open'>
	| card |
	card := RSPunchCardBuilder new.
	card objects: String withAllSubclasses.
	card addMetric: [:cls | cls numberOfMethods] name: 'NOM'.
	card addMetric: [:cls | cls linesOfCode ] name: 'NLC'.
	card addMetric: [:cls | cls numberOfVariables] name: 'NOV'.
	^ card build
]

{ #category : #shapes }
RSShapeExamples >> example38Transformable [
	<script: 'self new example38Transformable open'>
	| c |
	c := RSCanvas new.
	c add: (RSBox new
		size: 200;
		withBorder).
	c add: (RSBox new
		size: 100;
		cornerRadius: 20;
		withBorder).
	
	c add: (RSEllipse new
		extent: 200@60;
		withBorder).
	c add: (RSLabel new
		fontSize: 100;
		text: 'Kaguya Sama';
		yourself).
	c add: (RSBitmap new
		form: (self iconNamed: 'pharoBig');
		
		yourself).
	c add: (RSShapeFactory star
		size: 200;
		color: 'purple').
	c add: (self example31BasicGrapher asShape
		rotateByDegrees: 15;
		color: Color lightGray translucent).
	
	c add: (RSBox new
		size: 50;
		color: Color black).
	
	c add: (RSLine new
		withBorderAttachPoint;
		from: c nodes first;
		to: c nodes last).
	RSGridLayout new
		gapSize: 50;
		on: c nodes.
	c nodes do: [ :s | s model: s ].
	c nodes @ RSDraggableInteraction; @ (RSPopup text: [ :m | m class name ] ).
	
	c nodes allButLast @ RSTransformableInteraction.
	
	c @ RSCanvasController. 
	^ c 
]

{ #category : #shapes }
RSShapeExamples >> example39RoassalPackages [
	<script: 'self new example39RoassalPackages open'>
	| packagesRegExp packages canvas color labeled boxes stepping |
	packagesRegExp := { 'Roassal3*' }.
	    
	packages := packagesRegExp flatCollect: [ :regExp | 
	    RPackageOrganizer default packages 
	        select: [ :p | regExp match: p packageName ] ].
	    
	canvas := RSCanvas new.
	color := NSScale category20c.
	labeled := RSLabeledInteraction new.
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
	RSLineBuilder arrowedLine
	    withBorderAttachPoint;
	    canvas: canvas;
	    connectFrom: #yourself toAll: #dependentPackages.

	stepping := RSForceLayoutStepping new.
	stepping layout
	    length: 300;
	    charge: -300.
	canvas @ stepping.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #lines }
RSShapeExamples >> example40LabelingLine [

	<script: 'self new example40LabelingLine open'>
	| c shapeA shapeB line interactionLabel |
	c := RSCanvas new.

	shapeA := RSLabel model: 'A'.
	shapeB := RSLabel model: 'B'.
	c add: shapeA.
	c add: shapeB.
	shapeB translateBy: 100 @ 50.

	shapeA @ RSDraggableInteraction.
	shapeB @ RSDraggableInteraction.

	line := RSLine new
		        from: shapeA;
		        to: shapeB.
	line attachPoint: RSBorderAttachPoint new.
	c add: line.

	interactionLabel := RSLabeledInteraction new text: [ :notUsed | 
		                    line from model , ' -> ' , line to model ].
	interactionLabel shapeBuilder labelShape
		fontSize: 5;
		color: #red.
	interactionLabel location
		inner;
		middle.
	line @ interactionLabel.

	c @ RSCanvasController.
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example41Butterfly [

	<script: 'self new example41Butterfly open'>
	| model from to popup canvas com box g column c1 c2 c3 eb h |
	model := RSCanvas >> #zoomToFit.
	from := model senders collect: #compiledMethod.
	to := model implementors collect: #compiledMethod.

	popup := RSPopup text: [ :m | m selector ].
	canvas := RSCanvas new.
	box := [ :method | 
	    com := RSComposite new
	        model: method;
	        add: (RSLabel new text: '<<',method methodClass name,'>>'; fontSize: 8);
	        add: (RSLabel new text: method selector);
	        @ popup;
	        yourself.
	    RSVerticalLineLayout new
	        gapSize: 0;
	        alignCenter;
	        on: com children.
	    com adjustToChildren.
	    com padding: 10; withBorder.
	    com ].

	column := [ :col : align | 
	    g := col collect: [ :m | 
	        (box value: m)
	            scaleBy:((1 / col size) max: 0.2);
	            yourself.
	         ] as: RSGroup.
	    RSVerticalLineLayout new
	          perform: align;
	        gapSize: 2;
	        on: g.
	    g ].

	c1 := column value: from value: #alignRight.
	c2 := box value: model.
	c3 := column value: to value: #alignLeft.
	RSHorizontalLineLayout new
	    gapSize: 30;
	    alignMiddle;
	    on: { c1. c2. c3 }.
	eb := RSLineBuilder horizontalBezier
	    color: Color lightGray;
	     controlPointsController: (RSBlockCPController new
	        block: [:ed | | f t ap |
	            ap := ed attachPoint.
	            f := ap startingPointOf: ed.
	            t := ap endingPointOf: ed.
	            Array 
	                with: f
	                with: t x @ f y
	                with: f x @ t y
	                with: t. ]);
	    canvas: canvas;
	    withHorizontalAttachPoint;
	    width: 0.5;
	    yourself.
	eb useElementAssociations: (c1 collect: [:c | c -> c2 ]), (c3 collect: [:c | c2-> c ]).
	h := RSHighlightableInteraction new.
	h withLines.
	h highlightBorder: RSBorder new.

	canvas addAll: c1; add: c2; addAll: c3.
	canvas nodes @ h.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example42DirectedBezier [
	<script: 'self new example42DirectedBezier open'>
	| c shapes |
	c := RSCanvas new.
	shapes := {-200@ -50. 200@100. -200@ 150. 200@300 } collect: [:p |
		RSEllipse new
			withBorder;
			color: Color white;
			size: 150;
			position: p;
			yourself] as: RSGroup.
	shapes doWithIndex: [:s :i | s model: i ].
	shapes @ RSDraggableInteraction.
	c addAll: shapes.
	RSLineBuilder directedBezier
		canvas: c;
		shapes: shapes;
		useAssociations: { 1 -> 2 }.
	RSLineBuilder arrowedDirectedBezier
		canvas: c;
		shapes: shapes;
		useAssociations: { 4 -> 3}.
	c @ RSCanvasController.
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example43KeepLabelSize [
	<script: 'self new example43KeepLabelSize open
		setLabel: #''Use the wheel'' '>
	| canvas labels |
	canvas := RSCanvas new.
	
	labels := RSLabel models: String withAllSubclasses.
	RSNormalizer fontSize
		shapes: labels;
		normalize: [ :cls | cls linesOfCode ln +5 ].
	
	RSLineBuilder line
		color: Color red;
		canvas: canvas;
		shapes: labels;
		connectFrom: #superclass.
	canvas addAll: labels.
	RSTreeLayout on: labels.
	labels @ RSKeepFontSizeRatio.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example44Donna [
	<script: 'self new example44Donna open'>
	| text canvas horizontal vertical groups count |
	text := 'La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensiero

Sempre un amabile
Leggiadro viso
In pianto o in riso
È menzognero

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier

È sempre misero
Chi a lei s''affida
Chi le confida
Mal cauto il core

Pur mai non sentesi
Felice appieno
Chi su quel seno
Non liba amore

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier
'.
	count := 0.
	vertical := RSVerticalLineLayout new gapSize: 0.
	horizontal := RSHorizontalLineLayout new alignLabel.
	groups := (text splitOn: String cr,String cr) collect: [ :p | 
		| lines |
		lines := p lines collect: [ :line |
			| words |
			words := (line splitOn: ' ') collect: [ :word | 
				RSLabel new
					text: word;
					ifNotNil: [ :lbl |
						word = 'donna' 
							ifTrue: [ lbl bold; fontSize: 14 ].
						word = 'misero' 
							ifTrue: [ lbl fontSize: 20; color: 'red' ].
						word = 'pensier'
							ifTrue: [ 
								lbl italic; underline; color: 'blue'; fontSize: (count*4)+10.
								count := count+1.  ]
						 ];
					yourself
				].
			horizontal on: words.
			words asGroup asShape
			 ].
		vertical on: lines.
		
		lines asGroup asShape.
		].

	canvas := RSCanvas new.
	canvas addAll: groups.
	RSHorizontalFlowLayout new
		gapSize: 30;
		on: groups.
	canvas @ RSCanvasController.
	^ canvas

]
