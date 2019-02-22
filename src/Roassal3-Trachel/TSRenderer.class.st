"
I am the abstract of the renderes
"
Class {
	#name : #TSRenderer,
	#superclass : #TSObject,
	#instVars : [
		'athensCanvas'
	],
	#category : #'Roassal3-Trachel-Core'
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
