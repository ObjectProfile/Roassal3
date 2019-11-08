"
I handle the zoom interaction with mouse wheel event, also I handle all the zoom process
"
Class {
	#name : #RSZoomableCanvas,
	#superclass : #RSAbstractControlCanvas,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #hooks }
RSZoomableCanvas >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent do: [ :evt | self processEvent: evt ]
]

{ #category : #'events-processing' }
RSZoomableCanvas >> processEvent: evt [
	| sc delta camera dist scale position correct |
	
	animation ifNotNil: [ ^ self ].
	delta := evt isUp
		ifTrue: [ 1.25@0.2 ]
		ifFalse: [ 0.8@ -0.25 ].
	camera := evt camera.
	sc := camera scale * delta x.
	sc = (self scaleFor: sc) ifFalse: [ ^ self ].
	dist := evt position - camera position.
	correct := self
		correctCameraPosition: evt 
		inRectangle: (self expandedRectangle: evt)
		position: camera position + (dist * delta y)
		scale: sc.
	scale := TSScale sqrt range: { camera scale. sc }.
	position := TSScale sqrt range: { camera position. correct }.
	animation := evt canvas newAnimation
		duration: 200 milliSeconds;
		onStepDo: [ :t |
			camera 
				scale: (scale scale: t);
				translateTo: (position scale: t).
			evt signalUpdate ];
		when: TSAnimationEndEvent do: [ animation := nil ]
]

{ #category : #rendering }
RSZoomableCanvas >> renderOn: lb [
	lb text: 'Wheel' description: 'To zoom in-out the view'.
]
