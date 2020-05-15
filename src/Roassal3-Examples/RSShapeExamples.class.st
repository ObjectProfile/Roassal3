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
	canvas nodes first @ RSDraggable.
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
	RSEdgeBuilder line
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
	'triangle' 'vee' 'cross' 'arrow'
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
	
	label := RSLabeled new.
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
	labeled := RSLabeled new.
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
	boxes @ RSHighlightable defaultRed.
	RSGridLayout on: boxes.
	boxes @ (RSMenuActivable new
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
	RSEdgeBuilder orthoHorizontal
		markerEnd: (RSMarker new 
			offset: 6;
			shape: (RSShapeFactory triangle 
				color: Color red;
				size: 10;
				yourself));
		attachPoint: RSHorizontalAttachPoint new; 
		border: (RSBorder new);
		canvas: canvas;
		shapes: canvas nodes;
		connectFrom: #superclass.

	canvas edges first @ RSKeepBorderWidthRatio. 
	canvas edges first @ RSKeepMarkersSizeRatio.
	RSHorizontalTreeLayout new on: canvas nodes.
	^ canvas
]

{ #category : #shapes }
RSShapeExamples >> example24Highlightable [
	<script: 'self new example24Highlightable open'>
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
	box @ RSDraggable.
	c
		add:
			(RSLine new
				color: Color blue;
				from: box;
				to: circle).
	^ c
]

{ #category : #shapes }
RSShapeExamples >> example35RoassalPackages [
	<script: 'self new example35RoassalPackages open'>
	| packagesRegExp packages canvas color labeled boxes stepping |
	packagesRegExp := { 'Roassal3*' }.
	    
	packages := packagesRegExp flatCollect: [ :regExp | 
	    RPackageOrganizer default packages 
	        select: [ :p | regExp match: p packageName ] ].
	    
	canvas := RSCanvas new.
	color := NSScale category20c.
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

	stepping := RSForceLayoutStepping new.
	stepping layout
	    length: 300;
	    charge: -300.
	canvas @ stepping.
	canvas @ RSCanvasController.
	^ canvas
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
	box @ RSDraggable.
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
RSShapeExamples >> example38YikigeiAnimated [
	<script: 'self new example38YikigeiAnimated open'>
	| c size circles posOffset negOffset |
	c := RSCanvas new.
	size := 200.
	c addAll: (circles := #(magenta yellow red cyan) collect: [ :sel | 
	    c add: (RSEllipse new
	        size: size;
	        color: ((Color perform: sel) alpha: 0.4 );
	        yourself).
	    ]).
	c when: RSMouseMove do: [ :evt | 
	    posOffset := (evt position distanceTo: 0@0).
	    negOffset := posOffset negated.
	    circles first position: posOffset @ 0.
	    circles second position: 0 @ posOffset.
	    circles third position: negOffset @ 0.
	    circles fourth position: 0@negOffset.
	    c signalUpdate.
	     ].
	^ c
]

{ #category : #'data - svg' }
RSShapeExamples >> lizard [
	^ 'M560.8,71.3c19.5,0,38,4.5,55.5,13.4c17.5,8.9,32.1,21.2,43.5,36.8l273.7,373.7c37.6,50.7,56.5,108,56.5,171.8v169.9c0,25.5-8.9,47.2-26.8,65.1s-39.6,26.8-65.1,26.8H714.4c-25.5,0-47.2-8.9-65.1-26.8s-26.8-39.6-26.8-65.1v-84.7l-136.9-68.4H224.4c-25.5,0-47.2-8.9-65.1-26.8c-17.9-17.9-26.8-39.6-26.8-65.1v-15.3c0-38,13.5-70.4,40.4-97.4c27-27,59.4-40.4,97.4-40.4h201l20.1-61.3H163.1c-31.9,0-59.6-10.8-83-32.3c-23.4-21.5-36.4-48.1-39-79.7C20.4,240.3,10,211.3,10,178.4v-15.3c0-25.5,8.9-47.2,26.8-65.1c17.9-17.9,39.6-26.8,65.1-26.8H560.8L560.8,71.3z M928.8,836.9V667c0-50.1-14.8-95.4-44.5-135.9L610.1,157.4c-12.4-16.6-28.9-24.9-49.3-24.9H101.9c-8.3,0-15.5,3-21.5,9.1c-6.1,6.1-9.1,13.2-9.1,21.5c0,10.2,0.2,18.1,0.7,23.7c0.5,5.6,2,12,4.5,19.4s6.5,14.2,12,20.6c3.2-9.9,8.9-17.9,17-23.9s17.1-9.1,27-9.1h398.1v15.3H132.5c-8.3,0-15.5,3-21.5,9.1c-6.1,6.1-9.1,13.2-9.1,21.5c0,14,0.5,23.3,1.4,27.8c2.6,14,9.6,25.7,21.1,34.9c11.5,9.3,24.4,13.9,38.8,13.9h349.8c12.8,0,23.6,4.5,32.5,13.4c8.9,8.9,13.4,19.8,13.4,32.5c0,4.8-0.8,9.6-2.4,14.4l-30.6,91.9c-3.2,9.3-8.8,16.8-16.7,22.7c-8,5.9-16.9,8.9-26.8,8.9h-212c-21.1,0-39.1,7.5-54.1,22.5c-15,15-22.5,33-22.5,54.1v15.3c0,8.3,3,15.5,9.1,21.5c6.1,6.1,13.2,9.1,21.5,9.1h268.4c5.1,0,9.7,1.1,13.9,3.3l151.7,75.6c7.7,4.1,13.8,9.9,18.4,17.2c4.6,7.3,6.9,15.3,6.9,23.9v94.3c0,8.3,3,15.5,9.1,21.5c6.1,6.1,13.2,9.1,21.5,9.1h183.8c8.3,0,15.5-3,21.5-9.1C925.7,852.3,928.8,845.2,928.8,836.9L928.8,836.9z'
]

{ #category : #'data - svg' }
RSShapeExamples >> paper [
	^ 'M535.1,80.1c-16.8,0-31.2,6-43.2,18.1c-12,12-18.1,26.4-18.1,43.2v358.8h-17.5V211.3c0-16.8-6-31.2-18.1-43.2c-12-12-26.4-18.1-43.2-18.1c-16.8,0-31.1,6-43.2,18.1c-12,12-18.1,26.4-18.1,43.2v428.8l-84.2-112.1c-13.9-18.6-32.5-27.9-55.8-27.9c-19.3,0-35.8,6.8-49.5,20.5c-13.7,13.7-20.5,30.2-20.5,49.5c0,15.7,4.7,29.7,14.2,42.1l210,280c13.9,18.6,32.5,27.9,55.8,27.9h376.3c12.4,0,23.5-4,33.4-12c9.8-8,16.1-18.2,18.6-30.7l41.6-221.5c1.8-11.7,2.7-22.4,2.7-32.3V351.3c0-16.8-6-31.2-18.1-43.2c-12-12-26.4-18.1-43.2-18.1c-16.8,0-31.1,6-43.2,18.1c-12,12-18.1,26.4-18.1,43.2V500h-17.5V211.3c0-16.8-6-31.1-18.1-43.2c-12-12-26.4-18.1-43.2-18.1c-16.8,0-31.1,6-43.2,18.1c-12,12-18.1,26.4-18.1,43.2V500h-17.5V141.2c0-16.8-6-31.1-18.1-43.2C566.3,86,551.9,80,535.1,80.1L535.1,80.1z M535.1,10.1c24.8,0,47.6,6.5,68.6,19.4c21,12.9,37.1,30.5,48.4,52.8c6.9-1.4,14.6-2.2,23-2.2c36.1,0,67,12.9,92.7,38.6c25.7,25.7,38.6,56.6,38.6,92.7v9.3c38.3-2.2,71.2,9.5,98.7,35c27.5,25.5,41.3,57.4,41.3,95.7v272.4c0,14.6-1.4,29.7-4.3,45.4L900.3,890c-5.1,28.8-19,52.7-41.9,71.6c-22.8,18.9-49,28.4-78.5,28.4H403.8c-21.9,0-42.8-5-62.6-15.1c-19.9-10-36.4-23.6-49.5-40.7l-210-280C63,629.4,53.8,601.4,53.8,570c0-38.6,13.7-71.6,41-99c27.3-27.3,60.3-41,99-41c28.4,0,51.8,6.2,70,18.6V211.3c0-36.1,12.9-67,38.6-92.7C328,92.9,358.9,80,395,80c8.4,0,16.1,0.7,23,2.2c11.3-22.3,27.4-39.9,48.4-52.8c21-12.9,43.8-19.4,68.6-19.4L535.1,10.1z'
]

{ #category : #'data - svg' }
RSShapeExamples >> rock [
	^ 'M408.864 79.052c-22.401-33.898-66.108-42.273-98.813-23.588-29.474-31.469-79.145-31.093-108.334-.022-47.16-27.02-108.71 5.055-110.671 60.806C44.846 105.407 0 140.001 0 187.429v56.953c0 32.741 14.28 63.954 39.18 85.634l97.71 85.081c4.252 3.702 3.11 5.573 3.11 32.903 0 17.673 14.327 32 32 32h252c17.673 0 32-14.327 32-32 0-23.513-1.015-30.745 3.982-42.37l42.835-99.656c6.094-14.177 9.183-29.172 9.183-44.568V146.963c0-52.839-54.314-88.662-103.136-67.911zM464 261.406a64.505 64.505 0 0 1-5.282 25.613l-42.835 99.655c-5.23 12.171-7.883 25.04-7.883 38.25V432H188v-10.286c0-16.37-7.14-31.977-19.59-42.817l-97.71-85.08C56.274 281.255 48 263.236 48 244.381v-56.953c0-33.208 52-33.537 52 .677v41.228a16 16 0 0 0 5.493 12.067l7 6.095A16 16 0 0 0 139 235.429V118.857c0-33.097 52-33.725 52 .677v26.751c0 8.836 7.164 16 16 16h7c8.836 0 16-7.164 16-16v-41.143c0-33.134 52-33.675 52 .677v40.466c0 8.836 7.163 16 16 16h7c8.837 0 16-7.164 16-16v-27.429c0-33.03 52-33.78 52 .677v26.751c0 8.836 7.163 16 16 16h7c8.837 0 16-7.164 16-16 0-33.146 52-33.613 52 .677v114.445z'
]

{ #category : #'data - svg' }
RSShapeExamples >> scissors [
	^ 'M596.9,920h-96.8c-59.4,0-100.6-25.7-123.6-77.1c-8.4-17.9-12.6-36.5-12.6-55.8v-2.7c-22.6-10.9-40.6-27-53.9-48.4c-13.3-21.3-20-44.6-19.9-69.7c0-13.9,0.9-22.6,2.7-26.3H150c-38.6,0-71.6-13.7-99-41c-27.3-27.3-41-60.3-41-99c0-38.6,13.7-71.6,41-99s60.3-41,99-41h61.8l-24.1-9.3c-27-10.2-48.8-27.3-65.4-51.1c-16.6-23.8-24.9-50.4-24.9-79.6c0-38.6,13.7-71.6,41-99s60.3-41,99-41c16.8,0,33.3,3.1,49.8,9.3L630.7,220H850c38.6,0,71.6,13.7,99,41c27.3,27.3,41,60.3,41,99v365.3c0,32.1-9.8,60.8-29.5,86.1c-19.7,25.3-45.2,41.8-76.6,49.5l-185.4,46.5C665,915.8,631.1,920,596.9,920L596.9,920z M570.1,531.2L485.3,570l-89.1,40.5c-10.9,5.1-19.7,12.6-26.3,22.7c-6.6,10-9.9,21.1-9.9,33.1c0,16.8,6,31.1,18.1,43.2c12,12,26.4,18.1,43.2,18.1c9.5,0,17.8-1.8,25.1-5.5l184.9-84.2c-17.9-3.6-32.5-12.8-44-27.4c-11.5-14.6-17.2-31-17.2-49.2V531.2L570.1,531.2z M745.1,701.3c0-16.8-6-31.1-18.1-43.2c-12-12-26.4-18.1-43.2-18.1c-9.5,0-17.9,1.8-25.1,5.5l-158.6,72.2c-10.2,4.8-17,7.9-20.2,9.3c-3.3,1.4-8.8,4.6-16.7,9.3c-7.8,4.8-13.2,9.1-16.1,12.9c-2.9,3.8-5.8,9.1-8.7,15.9c-2.9,6.8-4.4,14.1-4.3,22.1c0,18.2,5.7,33.2,17.2,44.9c11.5,11.7,26.3,17.5,44.6,17.5c7.3,0,14.2-1.6,20.8-4.9l192.5-87.5c10.9-5.1,19.7-12.6,26.3-22.7c6.6-10,9.9-21.1,9.9-33.1L745.1,701.3z M618.2,290L262.8,154.4c-8.7-2.9-17.1-4.3-25.1-4.3c-19.3,0-35.8,6.8-49.5,20.5s-20.5,30.2-20.5,49.5c0,14.6,4.1,27.9,12.3,39.9s19.1,20.6,32.5,25.7l287.6,109.4v35h-350c-19.3,0-35.8,6.8-49.5,20.5c-13.7,13.7-20.5,30.2-20.5,49.5s6.8,35.8,20.5,49.5c13.7,13.7,30.2,20.5,49.5,20.5h292.6l127.4-58V403.8c0-23,8.4-42.3,25.1-58l60.7-55.8L618.2,290L618.2,290z M596.9,850c29.9,0,58.2-3.5,84.8-10.4L867,793.2c15.7-4,28.4-12.3,38.3-24.9c9.8-12.6,14.8-26.9,14.8-42.9V360.1c0-19.3-6.8-35.8-20.5-49.5c-13.7-13.7-30.2-20.5-49.5-20.5H681.7L607.3,359c-13.1,12-19.7,27-19.7,44.9v161.9c0,16.8,6,30.8,18.1,42.1c12,11.3,26.4,17,43.2,16.9c16.8,0,31.1-6.4,43.2-19.1c12-12.7,18.1-27.5,18.1-44.3V447.6h17.5v113.8c0,25.5-10.4,46.3-31.1,62.4c18.9,2.9,34.7,11.7,47.3,26.5c12.6,14.8,18.9,31.8,18.9,51.1c0,15.3-4.2,29.5-12.6,42.6c-8.4,13.1-19.5,22.8-33.4,29l-169.5,77.1H597L596.9,850z'
]

{ #category : #'data - svg' }
RSShapeExamples >> spock [
	^ 'M426.6,107.9c-16.3,0-29.9,5.8-40.6,17.4c-10.7,11.6-16.1,25.5-16.1,41.9c0,4.7,0.5,9.5,1.5,14.3L448,500h-13.3l-59.2-246.1c-3-12.9-9.8-23.5-20.2-31.6c-10.4-8.1-22.2-12.2-35.5-12.2c-16,0-29.4,5.8-40.3,17.4c-10.9,11.6-16.3,25.4-16.3,41.4c0,3.7,0.7,8.7,2,14.8c1,4.4,7.6,31.8,19.9,82.2c12.3,50.4,23.9,98.3,34.7,143.9c10.8,45.6,16.3,69.1,16.3,70.4v115.9L179.5,578.7c-11.6-8.8-24.7-13.3-39.3-13.3c-17.7,0-32.9,6.2-45.7,18.6c-12.8,12.4-19.1,27.5-19.1,45.2c0,22.8,9.5,41.5,28.6,56.1l258.8,193.5c11.6,8.8,24.5,13.3,38.8,13.3h354.3c11.2,0,21.3-3.5,30.1-10.5c8.8-7,14.6-15.9,17.4-26.8l51-204.7c2.7-10.2,4.4-25.2,5.1-45c0.7-19.8,2.2-34.4,4.6-43.9l59.2-244c1-4.1,1.5-8.5,1.5-13.3c0-15.6-5.6-29.1-16.9-40.3c-11.2-11.2-24.9-16.9-40.8-16.9c-12.9,0-24.7,4.3-35.2,13c-10.5,8.7-17.3,19.3-20.4,31.9L761,500h-13.3l67.4-279.2c1-4.7,1.5-9.5,1.5-14.3c0-16-5.4-29.6-16.3-40.8c-10.9-11.2-24.5-16.9-40.8-16.9c-12.9,0-24.6,4.1-35,12.2c-10.4,8.1-17.1,18.7-20.2,31.6l-74,307.3h-64.8l-83.7-348.1c-3-12.9-9.8-23.5-20.2-31.6C451.1,112,439.4,107.9,426.6,107.9L426.6,107.9z M755.8,957.3H401.5c-28.9,0-55-8.7-78.1-26l-258.8-194c-17-12.9-30.4-28.9-40.1-48c-9.7-19-14.5-39.1-14.6-60.2c0-35.7,12.8-66.2,38.3-91.3c25.5-25.2,56.2-37.8,91.9-37.8c8.5,0,16.9,0.9,25.3,2.8c8.4,1.9,15.4,3.7,21.2,5.6s12.7,5.4,20.9,10.5c8.2,5.1,14.1,9,17.8,11.8c3.7,2.7,10.3,7.8,19.7,15c9.4,7.3,15.8,12.1,19.1,14.6l-62.8-261.4c-2.4-11.9-3.6-21.9-3.6-30.1c0-31.7,10.2-59.2,30.6-82.7c20.4-23.5,46.3-36.9,77.6-40.3c4.7-29.6,18.4-54.2,41.1-73.8c22.7-19.6,49.1-29.3,79.4-29.3c28.2,0,53.4,8.8,75.5,26.3c22.1,17.5,36.6,40.1,43.4,67.6L598,355l42.3-177.7c6.8-27.6,21.3-50.1,43.4-67.6c22.1-17.5,47.3-26.3,75.5-26.3c29.6,0,55.6,9.2,77.8,27.6c22.3,18.4,36.3,42,42.1,71c31.7,3.4,58,16.7,79.1,39.8S990,272.3,990,304c0,10.2-1.2,19.9-3.6,29.1l-59.2,243.5c-1.7,7.5-2.5,18.9-2.5,34.2c0,17.3-2.2,35.7-6.7,55.2l-51.6,204.7c-6.4,25.5-20,46.4-40.6,62.5c-20.6,16.2-44,24.2-70.2,24.2L755.8,957.3z'
]
