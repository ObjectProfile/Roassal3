Class {
	#name : #RSMorphicHost,
	#superclass : #RSHost,
	#instVars : [
		'morph'
	],
	#category : #'Roassal3-Core'
}

{ #category : #private }
RSMorphicHost >> createMorph [
	"Create a Morph that contains myself. This is a private method"

	morph := RSAthensMorph new. 
	morph renderer: RSAthensRenderer new.
	morph canvas: canvas.
	^ morph
]

{ #category : #accessing }
RSMorphicHost >> morph [
	"Return the Athens morph used by the canvas to render the visualization"

	^ morph
]

{ #category : #accessing }
RSMorphicHost >> morph: aMorph [
	"Set the RSAthensMorph. The canvas will directly render in the morph"

	morph := aMorph
]

{ #category : #accessing }
RSMorphicHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	| window |
	self createMorph.
	window := morph openInWindowLabeled: aTitleAsString.
	window extent: 500 @ 500.
	morph privateOwner: window.
	^ window

]

{ #category : #signalling }
RSMorphicHost >> signalUpdate [
	"Signal a platform signal that the canvas should be refreshed. This is important when some shapes are modified (color or position)."

	morph changed
]
