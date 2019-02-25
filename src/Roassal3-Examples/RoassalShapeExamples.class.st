"
I use the RSShapeBuilder
"
Class {
	#name : #RoassalShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #shapes }
RoassalShapeExamples >> example01Basic [
	<script: 'self new example01Basic'>

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

{ #category : #shapes }
RoassalShapeExamples >> example02Basic [
	<script: 'self new example02Basic'>

	| v box box1 box2 line |
	v := RSView new.
	box := RSShapeBuilder box
		size: 100;
		interactionDo: [ :i | i draggable ].
	box1 := box element.
	box1 translateBy: 150@150.
	box2 := box element.
	v add: box1.
	line := RSEdgeBuilder line 
		color: Color red.
	v add: (line edgeFrom: box1 to: box2).

	v open
	



]

{ #category : #layouts }
RoassalShapeExamples >> example03LayoutBasic [
	<script: 'self new example03LayoutBasic'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red alpha: 0.5 ]
			ifFalse: [ Color blue alpha: 0.5 ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #lines }
RoassalShapeExamples >> example04Basic [
	<script: 'self new example04Basic'>

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
		position: [:m | m * 20 asPoint ];
		interactionDo: #draggable;
		elementsOn: (0 to: 1).
	path := [ :edge | String streamContents: [ :s|
		s nextPutAll:'M100 100L 0 0Z'.
		
		 ] ].
	line := RSEdgeBuilder linePath
		color: Color red;
		onElement;
		svgPath: path.
	v add: (line edgeFrom: elements first to: elements second).
	v addAll: elements.
	v camera scale: 4.
	v open
	
]
