"
I have basic examples of legend builder
"
Class {
	#name : #RSLegendExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Legend-Examples'
}

{ #category : #examples }
RSLegendExamples >> example01Basic [ 
	<script: 'self new example01Basic open'>
	| b |
	b := RSLegend new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b build.
	self assert: b shapes size = 2.
	self assert: b container shapes size = 1.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example02Border [
	<script: 'self new example02Border open'>
	| b |
	b := RSLegend new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b legendDo: [ :l | 
		l 
			withBorder;
			padding: 50 ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas.
]

{ #category : #examples }
RSLegendExamples >> example03Vertical [
	<script: 'self new example03Vertical open'>
	| b |
	b := RSLegend new.
	b 
		title: 'Mid Heros';
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b layout vertical gapSize: 20.
	b legendDo: [ :l | 
		l 
			withBorder;
			padding: (Margin left: 50 right: 10 top: 10  bottom: 50) ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example04Horizontal [
	<script: 'self new example04Horizontal open'>
	| b |
	b := RSLegend new.
	b 
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b legendDo: [ :l | 
		l
			withBorder;
			padding: 10 ].

	b layout horizontal gapSize: 20.
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example05Colors [
	<script: 'self new example05Colors open'>
	| b color |
	b := RSLegend new.
	
	color := NSScale category20.
	b 
		title: 'Mid Heros';
		text: 'Invoker' withCircleColor: color;
		text: 'Shadow Fiend' withCircleColor: color;
		text: 'Tinker' withCircleColor: color;
		text: 'Meepo' withCircleColor: Color black.
	b legendDo: [ :l |
		l
			withBorder;
			padding: 20 ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example06BoxColors [
	<script: 'self new example06BoxColors open'>
	| b color |
	b := RSLegend new.

	color := NSScale category20.
	b 
		text: 'Invoker' withBoxColor: color;
		text: 'Shadow Fiend' withBoxColor: color;
		text: 'Tinker' withBoxColor: color;
		text: 'Meepo' withBoxColor: color.
	b legendDo: [ :l | 
		l
			withBorder;
			padding: 20 ].
	b layout horizontal gapSize: 30.
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example07BoxFading [
	<script: 'self new example07BoxFading open'>
	| b |
	b := RSLegend new.
	b title: 'Legend'.
	b text: 'Number of lines of code' withFadingRamp: {0->'black'. 1->'red'}.
	b legendDo: [:l | l withBorder; padding: 10 ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example08Polygons [
	<script: 'self new example08Polygons open'>
	| b |
	b := RSLegend new.
	b title: 'Polygons'.
	#(diamond triangle star pentagon octagon) do: [ :selector | 
		b text: selector withShape: ((RSShapeFactory perform: selector) size: 15) ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example09Lines [
	<script: 'self new example09Lines open'>
	| b |
	b := RSLegend new.
	b title: 'Line with markers'.
	#(diamond triangle star pentagon octagon arrow) do: [ :selector |
		| line marker |
		marker := (RSShapeFactory perform: selector) size: 10.
		line := RSLine new markerEnd: marker; 
			startPoint: 0@0; 
			endPoint: 20@0;
			yourself.
		b text: selector withShape: line.
		 ].
	b build.
	b canvas @ RSCanvasController.
	^ b canvas
]

{ #category : #examples }
RSLegendExamples >> example10Location [
	<script: 'self new example10Location open setLabel: ''TSShape withAllSubclasses'''>
	| canvas classes b |
	canvas := RSCanvas new.
	classes := RSShape withAllSubclasses collect: [ :cls | 
		RSBox new
			draggable;
			popup;
			model: cls;
			height: cls numberOfMethods;
			width: (cls instVarNames size + 1) * 5 ] as: RSGroup.
	canvas addAll: classes.
	RSLineBuilder line
		withVerticalAttachPoint;
		width: 0.1;
		canvas: canvas;
		shapes: classes;
		connectFrom: #superclass.
	RSNormalizer color
		from: Color black;
		to: Color red;
		shapes: classes;
		normalize: #numberOfMethods.
	RSTreeLayout on: classes.
	b := RSLegend new.
	b container: canvas.
	b title: 'System complexity view'.
	b text: 'Number of lines of code' withFadingRamp: { 0->'black'. 1->'red'}.
	b 
		polymetricWidth: 'number of methods' 
			height: 'lines of code'
			box: 'a Pharo class'.
	b legendDo: [ :s | 
		s
			draggable;
			border:(RSBorder new
				color: Color red;
				dashArray: #(4));
			scaleBy: 0.5;
			padding: 15 ].
	b location right middle.
	b build.
	canvas @ RSCanvasController.
	^ canvas.
	



]

{ #category : #examples }
RSLegendExamples >> example11OnDemand [
	<script: 'self new example11OnDemand open setLabel: ''RSShape withAllSubclasses'''>
	| canvas classes b |
	canvas := RSCanvas new.
	classes := RSShape withAllSubclasses collect: [ :cls | 
		RSBox new
			draggable;
			popup;
			model: cls;
			height: cls numberOfMethods;
			width: (cls instVarNames size + 1) * 5 ] as: RSGroup.
	canvas addAll: classes.
	RSLineBuilder line
		withVerticalAttachPoint;
		width: 0.1;
		canvas: canvas;
		shapes: classes;
		connectFrom: #superclass.
	RSNormalizer color
		from: Color black;
		to: Color red;
		shapes: classes;
		normalize: #numberOfMethods.
	RSTreeLayout on: classes.
	b := RSLegend new.
	b container: canvas.
	b title: 'System complexity view'.
	b text: 'Number of lines of code' withFadingRamp: { 0->'black'. 1->'red'}.
	b 
		polymetricWidth: 'number of methods' 
			height: 'lines of code'
			box: 'a Pharo class'.
	b legendDo: [ :s | 
		s
			draggable;
			border:(RSBorder new
				color: Color red;
				dashArray: #(4));
			scaleBy: 0.5;
			padding: 15 ].
	b location right middle.
	b onDemand: 'Legend'; build.
	canvas @ RSCanvasController.
	^ canvas.
	



]

{ #category : #examples }
RSLegendExamples >> example12OnPopup [
	<script: 'self new example12OnPopup open'>
	| canvas shapes interaction popup |
	canvas := RSCanvas new.
	shapes := GoferOperation withAllSubclasses collect: [ :cls | 
		| boxes | 
		boxes := RSBox models: cls methods forEach: [:box :met | 
			box size: met linesOfCode*0.5+2; color: Color lightGray
			].
		RSGridLayout on: boxes.
		(boxes asShapeFor: cls)
			color: Color white;
			withBorder;
			padding: 5.
		] as: RSGroup.
	RSLineBuilder orthoVertical
		withVerticalAttachPoint;
		canvas: canvas;
		shapes: shapes;
		connectFrom: #superclass.
	interaction := RSLabeledInteraction new.
	interaction shapeBuilder labelShape fontSize: 5.
	popup := RSPopup new.
	popup shapeBuilder: [ :cls |"move this content to a class method"
		| composite lb colors |
		composite := RSComposite new.
		colors := NSScale category20c.
		lb := RSLegend new.
		lb container: composite.
		lb title: cls name.
		cls methods 
			do: [ :met | lb text: met selector withCircleColor: (colors scale: met selector) ].
		lb build.
		composite adjustToChildren.
		composite
			color: Color white;
			withBorder;
			padding: 5;
			yourself.
		 ].
	shapes @ interaction; @ popup; @ RSDraggableInteraction.
	RSTreeLayout on: shapes.
	canvas addAll: shapes.
	canvas @ RSCanvasController.
	^ canvas
]
