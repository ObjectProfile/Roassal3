"
I am a basic event for class RSHighlightable interaction
"
Class {
	#name : #TSHighlightableEvent,
	#superclass : #TSEvent,
	#instVars : [
		'element',
		'source',
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
	self shape: anElement shape
]

{ #category : #accessing }
TSHighlightableEvent >> interaction [
	^ interaction
]

{ #category : #accessing }
TSHighlightableEvent >> interaction: aInteraction [
	interaction := aInteraction
]

{ #category : #accessing }
TSHighlightableEvent >> source [
	^ source
]

{ #category : #accessing }
TSHighlightableEvent >> source: anElementOrView [
	source := anElementOrView
]
