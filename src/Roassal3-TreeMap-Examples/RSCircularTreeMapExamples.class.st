"
Just examples
"
Class {
	#name : #RSCircularTreeMapExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-TreeMap-Examples'
}

{ #category : #examples }
RSCircularTreeMapExamples >> example01Morph [
	<script: 'self new example01Morph open'>
	| b |
	b := RSCircularTreeMap new.
	b explore: Morph using: #subclasses.
	^ b
]

{ #category : #examples }
RSCircularTreeMapExamples >> example02Morph [
	<script: 'self new example02Morph open'>
	| b palette canvas |
	b := RSCircularTreeMap new.
	b baseRadius: 400.
	b explore: Collection using: #subclasses.
	b leafWeight: [ :cls | cls linesOfCode + 1 ].
	b build.
	canvas := b canvas.
	palette := NSScale ordinal rangeFrom: #('012642' '3d88b6' 'cbe5ef').
	b shapes do: [ :shape | 
		shape border: (RSBorder new 
			color: Color black;
			width: 2 - (shape depth*0.4) ).
		shape color: (palette scale: shape depth).
		shape isSLeaf ifTrue: [ | label |
			label := RSLabel new
				fontFamily: 'Impact';
				color: Color white;
				bold;
				border: (RSBorder new color: Color black);
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
