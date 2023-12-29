"
This interaction simulates the vertical scroll with mouse wheel.
When used will creates animations to translate canvas camera position
"
Class {
	#name : 'RSScrollWheelCanvasInteraction',
	#superclass : 'RSAbstractControlCanvasInteraction',
	#instVars : [
		'animation'
	],
	#category : 'Roassal-Interaction-Controls',
	#package : 'Roassal-Interaction',
	#tag : 'Controls'
}

{ #category : 'events - processing' }
RSScrollWheelCanvasInteraction >> move: aCanvas delta: delta [

	| correct p camera |
	animation ifNotNil: [ animation stop ].
	camera := aCanvas camera.

	correct := self correctCamera: camera.
	p := (correct - aCanvas camera position) abs max: 1@1.
	p := (p x raisedTo: 1/3) @ (p y raisedTo: 1/3).
	aCanvas camera translateBy: (0@ delta)/p.
	aCanvas signalUpdate.

	animation := aCanvas newAnimation
		duration: 300 milliSeconds;
		onStepDo: [ :t | aCanvas signalUpdate ];
		when: RSAnimationLoopEvent do: [ :e |
			animation := nil.
			correct := self correctCamera: camera.
			camera position = correct ifFalse: [
				aCanvas newAnimation
					duration: 200 milliSeconds;
					from: aCanvas camera position;
					to: correct;
					onStepDo: [ :t |
						aCanvas camera translateTo: t.
						aCanvas signalUpdate ] ]
			] for: self
]

{ #category : 'hooks' }
RSScrollWheelCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent send: #processEvent: to: self
]

{ #category : 'events - processing' }
RSScrollWheelCanvasInteraction >> processEvent: evt [
	| delta |
	delta := (evt isUp
		ifTrue: [ 1]
		ifFalse: [ -1 ]) * 30.
	self move: evt canvas delta: delta
]

{ #category : 'rendering' }
RSScrollWheelCanvasInteraction >> renderLegendOn: aLegendBuilder [
]
