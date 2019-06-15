"
I am a basic event for class RSHighlightable interaction
"
Class {
	#name : #TSHighlightableEvent,
	#superclass : #TSEvent,
	#instVars : [
		'element',
		'elements',
		'interaction'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSHighlightableEvent >> element [
	^ element
]

{ #category : #accessing }
TSHighlightableEvent >> element: anElement [
	element := anElement.
	self shape: anElement trachelShape
]

{ #category : #accessing }
TSHighlightableEvent >> elements [
	^ elements
]

{ #category : #accessing }
TSHighlightableEvent >> elements: aCollection [
	elements := aCollection
]

{ #category : #accessing }
TSHighlightableEvent >> interaction [
	^ interaction
]

{ #category : #accessing }
TSHighlightableEvent >> interaction: aInteraction [
	interaction := aInteraction
]
