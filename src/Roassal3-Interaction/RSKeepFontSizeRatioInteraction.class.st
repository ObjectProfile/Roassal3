"
Interaction for RSLabels, modify the font size based on the scale of the canvas
"
Class {
	#name : #RSKeepFontSizeRatioInteraction,
	#superclass : #RSAbstractScaleInteraction,
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #hooks }
RSKeepFontSizeRatioInteraction >> onShape: aLabel [
	| fontSize |
	aLabel isInACanvas ifFalse: [ self error: 'add this label to a canvas first' ].
	fontSize := aLabel fontSize.
	aLabel canvas when: RSScaleChangedEvent do: [ :evt |
		aLabel fontSize: (self scaleFor: evt) * fontSize.
		evt signalUpdate ]
]
