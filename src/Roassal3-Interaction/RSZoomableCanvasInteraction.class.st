"
I handle the zoom interaction with mouse wheel event, also I handle all the zoom process
"
Class {
	#name : #RSZoomableCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #examples }
RSZoomableCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ self.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ RSScrollBarsCanvasInteraction.
	canvas @ RSZoomToFitCanvasInteraction.
	canvas open.
]

{ #category : #events }
RSZoomableCanvasInteraction class >> zoomMove: aCanvas newScale: newScale [
	| scale camera position morphPosition |
	camera := aCanvas camera.
	scale := camera scale.
	
	morphPosition := aCanvas morph lastMousePosition - aCanvas morph bounds origin.
	position := camera fromPixelToSpace: morphPosition.
	
	aCanvas newAnimation 
		easing: RSEasingInterpolator backOut;
		duration: 200 milliSeconds;
		onStepDo: [ :t | | newPosition zero |
			"this method call a loadIdentity in the camera matrix"
			camera scale: (scale interpolateTo: newScale at: t).
			newPosition := camera fromSpaceToPixel: position.
			zero := camera fromSpaceToPixel: 0@0.
			camera matrix translation: morphPosition - (newPosition - zero)-(camera originMode gapDistance: camera).
			aCanvas signalUpdate ]
]

{ #category : #'events - processing' }
RSZoomableCanvasInteraction >> move: aCanvas evtPosition: evtPosition delta: delta [

	| camera newScale dist correct scale position |
	camera := aCanvas camera.
	
	newScale := camera scale * delta x.
	"if the allowed scale is not the same as the new scale we do not update"
	newScale = (self scaleFor: newScale) ifFalse: [ ^ self ].
	dist := evtPosition - camera position.
	correct := self
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: camera position + (dist * delta y)
		scale: newScale.
	scale := NSScale sqrt range: { camera scale. newScale }.
	position := NSScale sqrt range: { camera position. correct }.
	animation := aCanvas newAnimation
		duration: 200 milliSeconds;
		onStepDo: [ :t |
			camera
				scale: (scale scale: t);
				translateTo: (position scale: t).
			aCanvas signalUpdate ];
		when: RSAnimationEndEvent do: [ animation := nil ]
]

{ #category : #hooks }
RSZoomableCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent send: #processEvent: to: self
]

{ #category : #'events - processing' }
RSZoomableCanvasInteraction >> processEvent: evt [
	| delta |
	animation ifNotNil: [ ^ self ].
	delta := evt isUp
		ifTrue: [ 1.25 ]
		ifFalse: [ 0.8 ].
	self class zoomMove: evt canvas newScale: (self scaleFor: evt camera scale * delta).
]

{ #category : #rendering }
RSZoomableCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Wheel' description: 'To zoom in-out the view'
]
