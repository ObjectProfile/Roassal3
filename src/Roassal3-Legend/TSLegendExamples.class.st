"
I have basic examples of legend builder
"
Class {
	#name : #TSLegendExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Legend-Examples'
}

{ #category : #examples }
TSLegendExamples >> example01Basic [ 
	<script: 'self new example01Basic open'>
	| b |
	b := TSLegend new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b build.
	self assert: b shapes size = 2.
	self assert: b container shapes size = 1.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example02Border [
	<script: 'self new example02Border open'>
	| b |
	b := TSLegend new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b leyendDo: [ :l | 
		l 
			withBorder;
			padding: 50 ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas.
]

{ #category : #examples }
TSLegendExamples >> example03Vertical [
	<script: 'self new example03Vertical open'>
	| b |
	b := TSLegend new.
	b 
		title: 'Mid Heros';
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b layout vertical gapSize: 20.
	b leyendDo: [ :l | 
		l 
			withBorder;
			padding: (Margin left: 50 right: 10 top: 10  bottom: 50) ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example04Horizontal [
	<script: 'self new example04Horizontal open'>
	| b |
	b := TSLegend new.
	b 
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b leyendDo: [ :l | 
		l
			withBorder;
			padding: 10 ].

	b layout horizontal gapSize: 20.
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example05Colors [
	<script: 'self new example05Colors open'>
	| b color |
	b := TSLegend new.
	
	color := TSScale category20.
	b 
		title: 'Mid Heros';
		text: 'Invoker' withCircleColor: color;
		text: 'Shadow Fiend' withCircleColor: color;
		text: 'Tinker' withCircleColor: color;
		text: 'Meepo' withCircleColor: Color black.
	b leyendDo: [ :l |
		l
			withBorder;
			padding: 20 ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example06BoxColors [
	<script: 'self new example06BoxColors open'>
	| b color |
	b := TSLegend new.

	color := TSScale category20.
	b 
		text: 'Invoker' withBoxColor: color;
		text: 'Shadow Fiend' withBoxColor: color;
		text: 'Tinker' withBoxColor: color;
		text: 'Meepo' withBoxColor: color.
	b leyendDo: [ :l | 
		l
			withBorder;
			padding: 20 ].
	b layout horizontal gapSize: 30.
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example07BoxFading [
	<script: 'self new example07BoxFading open'>
	| b |
	b := TSLegend new.
	b title: 'Legend'.
	b text: 'Number of lines of code' withFadingRamp: {0->'black'. 1->'red'}.
	b leyendDo: [:l | l withBorder; padding: 10 ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example08Polygons [
	<script: 'self new example08Polygons open'>
	| b |
	b := TSLegend new.
	b title: 'Polygons'.
	#(diamond triangle star pentagon octagon) do: [ :selector | 
		b text: selector withShape: ((RSShape perform: selector) size: 15) ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example09Lines [
	<script: 'self new example09Lines open'>
	| b |
	b := TSLegend new.
	b title: 'Line with markers'.
	#(diamond triangle star pentagon octagon arrow) do: [ :selector |
		| line marker |
		marker := (RSShape perform: selector) size: 10.
		line := RSLine new markerEnd: marker; 
			startPoint: 0@0; 
			endPoint: 20@0;
			yourself.
		b text: selector withShape: line.
		 ].
	b build.
	b canvas @ RSControlsCanvas.
	^ b canvas
]

{ #category : #examples }
TSLegendExamples >> example10Location [
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
	RSEdgeBuilder line
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
	TSTreeLayout on: classes.
	b := TSLegend new.
	b container: canvas.
	b title: 'System complexity view'.
	b text: 'Number of lines of code' withFadingRamp: { 0->'black'. 1->'red'}.
	b 
		polymetricWidth: 'number of methods' 
			height: 'lines of code'
			box: 'a Pharo class'.
	b leyendDo: [ :s | 
		s
			draggable;
			border:(RSBorder new
				color: Color red;
				dashArray: #(4));
			scaleBy: 0.5;
			padding: 15 ].
	b location right middle.
	b build.
	canvas @ RSControlsCanvas.
	^ canvas.
	



]

{ #category : #examples }
TSLegendExamples >> example11OnDemand [
	<script: 'self new example11OnDemand open setLabel: ''TSShape withAllSubclasses'''>
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
	RSEdgeBuilder line
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
	TSTreeLayout on: classes.
	b := TSLegend new.
	b container: canvas.
	b title: 'System complexity view'.
	b text: 'Number of lines of code' withFadingRamp: { 0->'black'. 1->'red'}.
	b 
		polymetricWidth: 'number of methods' 
			height: 'lines of code'
			box: 'a Pharo class'.
	b leyendDo: [ :s | 
		s
			draggable;
			border:(RSBorder new
				color: Color red;
				dashArray: #(4));
			scaleBy: 0.5;
			padding: 15 ].
	b location right middle.
	b onDemand; build.
	canvas @ RSControlsCanvas.
	^ canvas.
	



]
