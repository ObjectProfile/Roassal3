"
I handle the zoom interaction with mouse wheel event, also I handle all the zoom process
"
Class {
	#name : 'RSZoomableCanvasInteraction',
	#superclass : 'RSAbstractControlCanvasInteraction',
	#instVars : [
		'animation'
	],
	#category : 'Roassal-Interaction-Controls',
	#package : 'Roassal-Interaction',
	#tag : 'Controls'
}

{ #category : 'events' }
RSZoomableCanvasInteraction class >> autoZoomMove: aCanvas newScale: newScale [
	| scale camera position morphPosition |
	camera := aCanvas camera.
	scale := camera scale.

	morphPosition := aCanvas morph bounds floatCenter - aCanvas morph bounds origin.
	position := camera fromPixelToSpace: morphPosition.
	self
		zoomMove: aCanvas
		pixelPosition: morphPosition
		spacePosition: position
		newScale: newScale
		useAnimation: true
]

{ #category : 'events' }
RSZoomableCanvasInteraction class >> zoomMove: aCanvas newScale: newScale useAnimation: aBoolean [
	| scale camera position morphPosition |
	camera := aCanvas camera.
	scale := camera scale.

	morphPosition := aCanvas lastMousePosition.
	position := camera fromPixelToSpace: morphPosition.

	self
		zoomMove: aCanvas
		pixelPosition: morphPosition
		spacePosition: position
		newScale: newScale
		useAnimation: aBoolean
]

{ #category : 'events' }
RSZoomableCanvasInteraction class >> zoomMove: aCanvas pixelPosition: morphPosition spacePosition: position newScale: newScale useAnimation: aBoolean [
	| scale camera |
	camera := aCanvas camera.
	scale := camera scale.
	aBoolean ifFalse: [ | newPosition zero |
		camera scale: newScale.
		newPosition := camera fromSpaceToPixel: position.
		zero := camera fromSpaceToPixel: 0@0.
		camera matrix translation: morphPosition - (newPosition - zero)-(camera originMode gapDistance: camera).

		aCanvas invalidate.
		^ self ].
	aCanvas newAnimation
		easing: RSEasingInterpolator backOut;
		duration: 200 milliSeconds;
		onStepDo: [ :t | | newPosition zero |
			"this method call a loadIdentity in the camera matrix"

			camera scale: (scale interpolateTo: newScale at: t).
			newPosition := camera fromSpaceToPixel: position.
			zero := camera fromSpaceToPixel: 0@0.
			camera matrix translation: morphPosition - (newPosition - zero)-(camera originMode gapDistance: camera).

			aCanvas invalidate ]
]

{ #category : 'configuration' }
RSZoomableCanvasInteraction >> noLimits [
	self configuration
		maxScale: SmallInteger maxVal;
		minScale: 0.0000000001
]

{ #category : 'hooks' }
RSZoomableCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSMouseWheelEvent send: #processEvent: to: self
]

{ #category : 'events - processing' }
RSZoomableCanvasInteraction >> processEvent: evt [
	| delta |
	animation ifNotNil: [ ^ self ].
	delta := evt isUp
		ifTrue: [ 1.25 ]
		ifFalse: [ 0.8 ].
	self class
		zoomMove: evt canvas
		newScale: (self scaleFor: evt camera scale * delta)
		useAnimation: self configuration shouldAnimateZoom
]

{ #category : 'rendering' }
RSZoomableCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Wheel' description: 'To zoom in-out the view'
]
