"
I am the abstract of the renderes
"
Class {
	#name : #RSRenderer,
	#superclass : #RSObject,
	#instVars : [
		'athensCanvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSRenderer >> canvas [
	^ athensCanvas 
]

{ #category : #accessing }
RSRenderer >> canvas: aCanvas [
	"aCanvas is AthensCanvas"
	athensCanvas := aCanvas
]

{ #category : #accessing }
RSRenderer >> visitCanvas: canvas [
]
