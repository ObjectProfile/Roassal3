"
I add an interaction for the view
"
Class {
	#name : #RSZoomToFitView,
	#superclass : #RSAbstractControlView,
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'zoom animation' }
RSZoomToFitView >> animatedZoomToFit: aView [
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
RSZoomToFitView >> onElement: aView [
	aView when: TSKeyUp do: [ :evt | self processKeyUp: evt ].
	aView when: TSExtentChangedEvent do: [ self zoomToFitIfNecessary: aView ].
	self zoomToFit: aView.
]

{ #category : #accessing }
RSZoomToFitView >> order [
	^ 3
]

{ #category : #'private - events' }
RSZoomToFitView >> processKeyUp: evt [
	evt keyValue == 49 "Character space"  ifFalse:  [ ^ self ].
	self animatedZoomToFit: evt view
]

{ #category : #rendering }
RSZoomToFitView >> renderOn: lb [
	lb text: 'Space' description: 'To zoom to fit the view'.
]

{ #category : #'zoom animation' }
RSZoomToFitView >> zoomToFit: aView [
	| camera rect extent sc viewRect |
	camera := aView camera.
	rect := aView encompassingRectangle.
	extent := aView extent * 0.9.
	sc := extent / (rect extent max: 1 @ 1).
	sc := self scaleFor: (sc x min: sc y).
	viewRect := Rectangle 
		rsCenter: rect rsCenter
		extent: aView extent / 1.
	camera translateTo: rect rsCenter.
	(self configuration shouldUseBasicZoom 
		and: [ viewRect containsRect: rect ]) ifTrue: [ 
		camera scale: 1.
	]ifFalse: [ camera scale: sc].
	
	aView signalUpdate.
	
]

{ #category : #'zoom animation' }
RSZoomToFitView >> zoomToFitIfNecessary: aView [
	self configuration shouldZoomToFitOnExtendChanged ifFalse: [ ^ self ].
	self zoomToFit: aView
]
