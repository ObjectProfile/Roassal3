"
Small example of how to create an interaction added a new animation in the canvas.
Please check how to use this class here: `RSBlink class>> #example`
"
Class {
	#name : 'RSBlink',
	#superclass : 'RSInteraction',
	#category : 'Roassal-Interaction-Core',
	#package : 'Roassal-Interaction',
	#tag : 'Core'
}

{ #category : 'hooks' }
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
		for: self
]
