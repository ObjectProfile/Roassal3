"
I add an interaction for the view
"
Class {
	#name : #TSZoomToFitCanvas,
	#superclass : #TSAbstractControlCanvas,
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'zoom animation' }
TSZoomToFitCanvas >> animatedZoomToFit: aView [
	| sc position scale camera pos |
	camera := aView camera.
	sc := camera scale.
	pos := camera position.
	self zoomToFit: aView. 
	
	position := TSScale linear
		from: pos;
		to: camera position.
	scale := TSScale linear
		from: sc;
		to: camera scale.
	camera translateTo: pos; scale: sc.
	sc < 1 ifTrue: [ 
		aView newAnimation
			duration: 500 milliSeconds;
			easing: TSEasing backOut;
			onStepDo: [ :t | 
				camera
					position: (position scale: t);
					scale: (scale scale: t).
				aView signalUpdate ].
		^ self ].
	aView newAnimation 
		delay: 150 milliSeconds;
		duration: 700 milliSeconds;
		easing: TSEasing backOut;
		onStepDo: [:t |
			camera position: (position scale: t).
			aView signalUpdate].
	aView newAnimation
		duration: 300 milliSeconds;
		easing: TSEasing exp;
		onStepDo: [ :t | 
				camera scale: (scale scale: t).
				aView signalUpdate]
	
	
]

{ #category : #hooks }
TSZoomToFitCanvas >> onShape: aCanvas [
	aCanvas when: RSKeyUp do: [ :evt | self processKeyUp: evt ].
	aCanvas when: RSExtentChangedEvent do: [ self zoomToFitIfNecessary: aCanvas ].
	self configuration shouldZoomToFitOnStart ifFalse: [ ^ self ].
	self zoomToFit: aCanvas.
]

{ #category : #'private - events' }
TSZoomToFitCanvas >> processKeyUp: evt [
	evt keyValue == 49 "Character space"  ifFalse:  [ ^ self ].
	self animatedZoomToFit: evt canvas
]

{ #category : #rendering }
TSZoomToFitCanvas >> renderOn: lb [
	lb text: 'Space' description: 'To zoom to fit the view'.
]

{ #category : #'zoom animation' }
TSZoomToFitCanvas >> zoomToFit: aCanvas [
	| camera shapesRect extent sc viewRect original |
	camera := aCanvas camera.
	shapesRect := self encompassingRectangleFor: aCanvas.
	extent := aCanvas extent * 0.9.
	sc := extent / (shapesRect extent max: 1 @ 1).
	original := sc x min: sc y.
	sc := self scaleFor: original.
	viewRect := Rectangle 
		rsCenter: shapesRect rsCenter
		extent: aCanvas extent / 1.
	camera translateTo: shapesRect rsCenter.
	self configuration shouldUseBasicZoom ifTrue: [ 
		(viewRect containsRect: shapesRect )
			ifTrue: [ camera scale: 1]
			ifFalse: [
				self configuration minScale: original.
				camera scale: original ]
	] ifFalse: [ camera scale: sc].
	self removeRectanglesFor: aCanvas.
	aCanvas signalUpdate.
	
]

{ #category : #'zoom animation' }
TSZoomToFitCanvas >> zoomToFitIfNecessary: aView [
	self configuration shouldZoomToFitOnExtendChanged ifFalse: [ ^ self ].
	self zoomToFit: aView
]
