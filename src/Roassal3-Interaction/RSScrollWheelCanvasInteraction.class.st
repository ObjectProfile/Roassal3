"
I am a interaction for translate the canvas in vertical position with the mouse wheel
"
Class {
	#name : #RSScrollWheelCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'events - processing' }
RSScrollWheelCanvasInteraction >> move: aCanvas delta: delta [

	| correct p |
	animation ifNotNil: [ animation stop ].

	correct := self correctCameraPosition: aCanvas.
	p := (correct - aCanvas camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.
	aCanvas camera translateBy: (0@ delta)/p.
	aCanvas signalUpdate.


	animation := aCanvas newAnimation
		duration: 300 milliSeconds;
		onStepDo: [ :t | aCanvas signalUpdate ];
		when: RSAnimationLoopEvent do: [ :e | | point |
			animation := nil.
			point := self correctCameraPosition: aCanvas.
			(aCanvas camera position = point)
			ifFalse: [
				aCanvas newAnimation
					duration: 200 milliSeconds;
					from: aCanvas camera position;
					to: point;
					onStepDo: [ :t |
						aCanvas camera translateTo: t.
						aCanvas signalUpdate ] ]
			]
]

{ #category : #hooks }
RSScrollWheelCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent send: #processEvent: to: self
]

{ #category : #'events - processing' }
RSScrollWheelCanvasInteraction >> processEvent: evt [
	| delta |
	delta := (evt isUp
		ifTrue: [ -1]
		ifFalse: [ 1 ]) * 30.
	self move: evt canvas delta: delta
]

{ #category : #rendering }
RSScrollWheelCanvasInteraction >> renderLegendOn: aLegendBuilder [
]
