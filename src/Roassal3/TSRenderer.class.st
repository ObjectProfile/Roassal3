"
I am the abstract of the renderes
"
Class {
	#name : #TSRenderer,
	#superclass : #TSObject,
	#instVars : [
		'athensCanvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
TSRenderer >> canvas [
	^ athensCanvas 
]

{ #category : #accessing }
TSRenderer >> canvas: aCanvas [
	"aCanvas is AthensCanvas"
	athensCanvas := aCanvas
]

{ #category : #accessing }
TSRenderer >> visitCanvas: canvas [
]
