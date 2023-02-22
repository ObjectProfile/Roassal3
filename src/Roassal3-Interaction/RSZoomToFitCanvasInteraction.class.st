"
I put an interaction to zoom to fit the entire visualization inside the visible area provided by the morp.

I work with `RSCanvasController` and `RSControlConfiguration`.

Press `bar space key` in a canvas to zoom to fit

Note: this interaction changes the RSCamera of the canvas for a custom camera.
"
Class {
	#name : #RSZoomToFitCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #examples }
RSZoomToFitCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas originTopLeft.
	canvas @ self.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSScrollBarsCanvasInteraction.
	canvas open.
]

{ #category : #'zoom animation' }
RSZoomToFitCanvasInteraction >> animatedZoomToFit: aCanvas [
	| oldScale newPosition newScale camera oldPosition |
	camera := aCanvas camera.
	oldScale := camera scale.
	oldPosition := camera position.
	aCanvas zoomToFit. 
	
	newPosition := camera position.
	newScale := camera scale.
	
	camera translateTo: oldPosition; scale: oldScale.
	oldScale < 1 ifTrue: [ 
		aCanvas newAnimation
			duration: 500 milliSeconds;
			easing: RSEasingInterpolator backOut;
			onStepDo: [ :t | 
				camera
					position: (oldPosition interpolateTo: newPosition at: t);
					scale: (oldScale interpolateTo: newScale at: t).
				aCanvas signalUpdate ].
		^ self ].
	"when the visualization is bigger and it has to be smaller to fit in the morph extent"
	aCanvas animationFrom: {
		aCanvas transitionAnimation
			duration: 500 milliSeconds;
			easing: RSEasingInterpolator backOut;
			onStepDo: [:t |
				camera position: (oldPosition interpolateTo: newPosition at: t).
				camera scale: (oldScale interpolateTo: newScale at: t).
				aCanvas signalUpdate];
			yourself.
		}
	
]

{ #category : #hooks }
RSZoomToFitCanvasInteraction >> cameraFor: aCanvas [
	^ RSConfigurableCamera new
		canvas: aCanvas;
		zoomInteraction: self;
		yourself
]

{ #category : #hooks }
RSZoomToFitCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSKeyUp send: #processKeyUp: to: self.
	aCanvas when: RSExtentChangedEvent send: #zoomToFitIfNecessary: to: self.
	aCanvas camera: (self cameraFor: aCanvas).
	self configuration shouldZoomToFitOnStart ifFalse: [ ^ self ].
	self zoomToFitOnStart: aCanvas
]

{ #category : #'private - events' }
RSZoomToFitCanvasInteraction >> processKeyUp: evt [
	evt keyName = #SPACE ifFalse:  [ ^ self ].
	self animatedZoomToFit: evt canvas
]

{ #category : #rendering }
RSZoomToFitCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Space' description: 'To zoom to fit the view'
]

{ #category : #'zoom animation' }
RSZoomToFitCanvasInteraction >> zoomToFitIfNecessary: evt [
	self configuration shouldZoomToFitOnExtendChanged ifFalse: [ ^ self ].
	evt canvas zoomToFit
]

{ #category : #'zoom animation' }
RSZoomToFitCanvasInteraction >> zoomToFitOnStart: aCanvas [
	aCanvas newAnimation
		duration: 60 milliSeconds;
		onStepDo: [ aCanvas zoomToFit ]
]
