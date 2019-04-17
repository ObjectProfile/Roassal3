"
I have basic examples of legend builder
"
Class {
	#name : #RSLegendExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Legend'
}

{ #category : #examples }
RSLegendExamples >> example01Basic [ 
	<script: 'self new example01Basic'>
	| b |
	b := RSLegendBuilder new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b build.
	self assert: b elements size = 2.
	self assert: b view elements size = 1.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example02Border [
	<script: 'self new example02Border'>
	| b |
	b := RSLegendBuilder new.
	b text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
	b text: 'Blue links = dependencies; layout = force based layout on the inheritance links'.
	b shape border: TSBorder new.
	b padding: 50.
	b build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example03Vertical [
	<script: 'self new example03Vertical'>
	| b |
	b := RSLegendBuilder new.
	b 
		title: 'Mid Heros';
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b shape border: TSBorder new.
	b layout vertical gapSize: 20.
	b 
		padding: 50;
		build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example04Horizontal [
	<script: 'self new example04Horizontal'>
	| b |
	b := RSLegendBuilder new.
	b 
		text: 'Invoker';
		text: 'Shadow Fiend';
		text: 'Tinker';
		text: 'Meepo'.
	b shape border: TSBorder new.
	b layout horizontal gapSize: 20.
	b 
		padding: 10;
		build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example05Colors [
	<script: 'self new example05Colors'>
	| b color |
	b := RSLegendBuilder new.
	
	color := TSScale category20.
	b 
		title: 'Mid Heros';
		text: 'Invoker' withCircleColor: color;
		text: 'Shadow Fiend' withCircleColor: color;
		text: 'Tinker' withCircleColor: color;
		text: 'Meepo' withCircleColor: color.
	b shape border: TSBorder new.
	b 
		padding: 50;
		build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example06BoxColors [
	<script: 'self new example06BoxColors'>
	| b color |
	b := RSLegendBuilder new.

	color := TSScale category20.
	b 
		text: 'Invoker' withBoxColor: color;
		text: 'Shadow Fiend' withBoxColor: color;
		text: 'Tinker' withBoxColor: color;
		text: 'Meepo' withBoxColor: color.
	b shape border: TSBorder new.
	b layout horizontal gapSize: 30.
	b 
		padding: 50;
		build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example07BoxFading [
	<script: 'self new example07BoxFading'>
	| b |
	b := RSLegendBuilder new.
	b title: 'Legend'.
	b text: 'Number of lines of code' withFadingRamp: {0->'black'. 1->'red'}.
	b shape border: TSBorder new.
	b build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example08Polygons [
	<script: 'self new example08Polygons'>
	| b |
	b := RSLegendBuilder new.
	b title: 'Polygons'.
	#(diamond triangle star pentagon octagon) do: [ :selector |
		b custom: selector shape: (b 
			horizontalComposite: ((RSShapeBuilder perform: selector) size: 15)
			text: b defLabel).
		 ].
	b build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example09Lines [
	<script: 'self new example09Lines'>
	| b |
	b := RSLegendBuilder new.
	b title: 'Line with markers'.
	#(diamond triangle star pentagon octagon vee) do: [ :selector |
		| line marker |
		marker := (RSShapeBuilder perform: selector) size: 10; element.
		line := RSSingleEdgeBuilder line markerEnd: marker; from: 0@0; to: 20@0.
		b custom: selector shape: (b 
			horizontalComposite: line
			text: b defLabel).
		 ].
	b build.
	b view @ RSControlsView.
	b view open.
]

{ #category : #examples }
RSLegendExamples >> example10Location [
	<script: 'self new example10Location'>
	| v shape elements b |
	v := RSView new.
	shape := RSShapeBuilder rectangle
		draggable;
		popup;
		height: #numberOfMethods;
		width: [ :cls | (cls instVarNames size + 1 )* 5 ].
	
	elements := shape elementsOn: (TSShape withAllSubclasses).
	v addAll: elements.
	RSEdgeBuilder line
		withVerticallAttachPoint;
		width: 0.1;
		view: v;
		elements: elements;
		connectFrom: #superclass.
	RSNormalizer color
		from: Color black;
		to: Color red;
		elements: elements;
		normalize: #numberOfMethods.
	RSTreeLayout on: elements.
	b := RSLegendBuilder new.
	b view: v.
	b title: 'System complexity view'.
	b text: 'Number of lines of code' withFadingRamp: { 0->'black'. 1->'red'}.
	b 
		polymetricWidth: 'number of methods' 
			height: 'lines of code'
			box: 'a Pharo class'.
	b padding: 15.
	b shape border:(TSBorder new
		color: Color red;
		dashArray: #(4)).
	"b location right middle."
	b build.
	v elements last scaleBy: 0.5.
	v @ RSControlsView.
	v open setLabel: 'TSShape withAllSubclasses'.
	




]
