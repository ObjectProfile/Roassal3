"
I am a basic event for class RSHighlightable interaction
"
Class {
	#name : #RSHighlightableEvent,
	#superclass : #RSEvent,
	#instVars : [
		'source',
		'interaction'
	],
	#category : #'Roassal3-Event'
}

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
