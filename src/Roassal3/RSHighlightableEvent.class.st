"
I am a basic event for class RSHighlightable interaction
"
Class {
	#name : #RSHighlightableEvent,
	#superclass : #RSEvent,
	#instVars : [
		'element',
		'source',
		'interaction'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
RSHighlightableEvent >> element [
	^ element
]

{ #category : #accessing }
RSHighlightableEvent >> element: anElement [
	element := anElement.
	self shape: anElement shape
]

{ #category : #accessing }
RSHighlightableEvent >> interaction [
	^ interaction
]

{ #category : #accessing }
RSHighlightableEvent >> interaction: aInteraction [
	interaction := aInteraction
]

{ #category : #accessing }
RSHighlightableEvent >> source [
	^ source
]

{ #category : #accessing }
RSHighlightableEvent >> source: anElementOrView [
	source := anElementOrView
]
