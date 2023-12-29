"
Just examples
"
Class {
	#name : 'RSCircularTreeMapExamples',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-TreeMap-Examples',
	#package : 'Roassal-TreeMap-Examples'
}

{ #category : 'examples' }
RSCircularTreeMapExamples >> example01Morph [
	<script: 'self new example01Morph open'>
	| b |
	b := RSCircularTreeMap new.
	b explore: Morph using: #subclasses.
	^ b
]

{ #category : 'examples' }
RSCircularTreeMapExamples >> example02Morph [
	<script: 'self new example02Morph open'>
	| b palette canvas |
	canvas := RSCanvas new.
	canvas @ (RSCanvasController new
		in: [ :interaction | interaction configuration maxScale: 30 ];
		yourself).
	b := RSCircularTreeMap new.
	b container: canvas.
	b baseRadius: 500.
	b explore: Morph using: #subclasses.
	b leafWeight: [ :cls | cls linesOfCode + 1 ].
	b build.
	palette := NSScale ordinal rangeFrom: #('012642' '3d88b6' 'cbe5ef').
	b shapes do: [ :shape | | paint color |
		shape border: (RSBorder new
			color: Color black;
			width: 2 - (shape depth*0.4) ).
		color := palette scale: shape depth.
		paint := RadialGradientPaint fromArray: { 0->color muchLighter. 0.95 -> color }.
		paint center: 0@0; focalPoint: 0@0; radius: shape radius.
		shape paint: paint.
		shape isSLeaf ifTrue: [ | label |
			label := RSLabel new
				fontFamily: 'Impact';
				color: Color white;
				bold;
				border: (RSBorder new color: Color black; width: 0.7);
				text: shape model asString;
				position: shape position;
				yourself.
			label width > shape width ifTrue: [
				label scaleBy: (shape width / label width) * 0.9
				 ].
			canvas add: label.
		] ].
	b shapes @ RSPopup new.
	^ canvas
]

{ #category : 'examples' }
RSCircularTreeMapExamples >> example03Evolving [
	"original example created by Alexandre Bergel for Roassal1 ;)"

	<script: 'self new example03Evolving open'>
	| canvas t |
	canvas := RSCanvas new.
	canvas @ RSCanvasController.

	"we prepare the data"
	t := 0.

	canvas add: (RSLabel new
			 text: '+1';
			 isFixed: true;
			 position: 20 @ 20;
			 when: RSMouseClick do: [ :evt |
				 t := t + 1.
				 canvas shapes copy do: #remove.
				 "RSCircularTreeMap new"
				 RSTreeMap new
					 in: [ :b | b boxShape noPaint ];
					 container: canvas;
					 leafWeight: #yourself;
					 explore: 1 using: [ :n |
						 {
							 (n * 2).
							 (n * 2 + 1) } select: [ :each | each <= t ] ];
					 build.
				 canvas shapes @ RSPopup.
				 canvas zoomToFit.
				 canvas signalUpdate ]
			 for: self;
			 yourself).
	^ canvas
]
