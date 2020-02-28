"
I am a interaction for translate the canvas in vertical position with the mouse wheel
"
Class {
	#name : #RSScrollWheelCanvas,
	#superclass : #RSAbstractControlCanvas,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #hooks }
RSScrollWheelCanvas >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent do: [ :evt | self processEvent: evt ]
]

{ #category : #'events-processing' }
RSScrollWheelCanvas >> processEvent: evt [
	| delta correct p |
	delta := (evt isUp
		ifTrue: [ -1]
		ifFalse: [ 1 ]) * 30.
	correct := self correctCameraPosition: evt.
	p := (correct - evt camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.
	evt camera translateBy: (0@ delta)/p.
	evt signalUpdate.
	
	animation ifNotNil: [ animation stop ].
	animation := evt canvas newAnimation
		duration: 300 milliSeconds;
		onStepDo: [ :t | evt canvas signalUpdate ];
		when: RSAnimationLoopEvent do: [ :e | 
			evt canvas newAnimation
				duration: 200 milliSeconds;
				from: evt camera position;
				to: (self correctCameraPosition: evt);
				onStepDo: [ :t | 
					evt camera translateTo: t.
					evt signalUpdate
					 ].
			].
	
	
	
]

{ #category : #rendering }
RSScrollWheelCanvas >> renderLegendOn: aLegendBuilder [
	
]
