"
I am a simple interaction that allows to shapes keep size ratio or with in the case of the border
"
Class {
	#name : #RSKeepBorderWidthRatio,
	#superclass : #RSInteraction,
	#instVars : [
		'menuBlock'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSKeepBorderWidthRatio >> onElement: anElement [

	| view width |
	anElement isInACanvas ifFalse: [ self error: 'anElement needs to be part of one view' ].
	view := anElement view.
	width := anElement border width.
	view when: TSScaleChangedEvent do: [:evt | 
		anElement border width: 1 / evt newScale * width.
		view signalUpdate. ]. 
]
