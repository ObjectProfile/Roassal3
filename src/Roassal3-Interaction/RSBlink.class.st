"
Small example of how to create an interaction added a new animation in the canvas.
Please check how to use this class here: `RSBlink class>> #example`
"
Class {
	#name : #RSBlink,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #examples }
RSBlink class >> example [
	| canvas shapes |
	canvas := RSCanvas new.
	shapes := RSCircle models: (1 to: 9).
	shapes size: 30.
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	shapes when: RSMouseClick do: [ :evt | evt shape @ self ].

	shapes fifth @ self.
	canvas zoomToFit.
	^ canvas open
		setLabel: 'Click one ellipse';
		yourself
]

{ #category : #hooks }
RSBlink >> onShape: aShape [
	| canvas previousColor |
	canvas := aShape canvas.
	previousColor := aShape color.
	aShape color: Color red.
	canvas signalUpdate.
	canvas newAnimation
		duration: 0.5 second;
		onStepDo: [ :t | aShape signalUpdate ];
		when: RSAnimationEndEvent do: [ :evt |
			aShape color: previousColor.
			canvas signalUpdate ]
]
