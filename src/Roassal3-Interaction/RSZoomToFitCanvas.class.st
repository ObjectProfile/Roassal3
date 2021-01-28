"
I add an interaction for the view
"
Class {
	#name : #RSZoomToFitCanvas,
	#superclass : #RSAbstractControlCanvas,
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'zoom animation' }
RSZoomToFitCanvas >> animatedZoomToFit: aCanvas [
	| sc position scale camera pos |
	camera := aCanvas camera.
	sc := camera scale.
	pos := camera position.
	aCanvas zoomToFit. 
	
	position := NSScale linear
		from: pos;
		to: camera position.
	scale := NSScale linear
		from: sc;
		to: camera scale.
	camera translateTo: pos; scale: sc.
	sc < 1 ifTrue: [ 
		aCanvas newAnimation
			duration: 500 milliSeconds;
			easing: RSEasing backOut;
			onStepDo: [ :t | 
				camera
					position: (position scale: t);
					scale: (scale scale: t).
				aCanvas signalUpdate ].
		^ self ].
	aCanvas newAnimation 
		delay: 150 milliSeconds;
		duration: 700 milliSeconds;
		easing: RSEasing backOut;
		onStepDo: [:t |
			camera position: (position scale: t).
			aCanvas signalUpdate].
	aCanvas newAnimation
		duration: 300 milliSeconds;
		easing: RSEasing exp;
		onStepDo: [ :t | 
				camera scale: (scale scale: t).
				aCanvas signalUpdate ]
	
	
]

{ #category : #hooks }
RSZoomToFitCanvas >> cameraFor: aCanvas [
	^ RSConfigurableCamera new
		canvas: aCanvas;
		zoomInteraction: self;
		yourself
]

{ #category : #hooks }
RSZoomToFitCanvas >> onShape: aCanvas [
	aCanvas when: RSKeyUp do: [ :evt | self processKeyUp: evt ].
	aCanvas when: RSExtentChangedEvent do: [ self zoomToFitIfNecessary: aCanvas ].
	aCanvas camera: (self cameraFor: aCanvas). 
	self configuration shouldZoomToFitOnStart ifFalse: [ ^ self ].
	aCanvas zoomToFit.
]

{ #category : #'private - events' }
RSZoomToFitCanvas >> processKeyUp: evt [
	evt keyName = #SPACE ifFalse:  [ ^ self ].
	self animatedZoomToFit: evt canvas
]

{ #category : #rendering }
RSZoomToFitCanvas >> renderLegendOn: lb [
	lb text: 'Space' description: 'To zoom to fit the view'.
]

{ #category : #'zoom animation' }
RSZoomToFitCanvas >> zoomToFitIfNecessary: aCanvas [
	self configuration shouldZoomToFitOnExtendChanged ifFalse: [ ^ self ].
	aCanvas zoomToFit
]
