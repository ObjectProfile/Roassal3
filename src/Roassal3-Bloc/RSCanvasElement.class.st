Class {
	#name : #RSCanvasElement,
	#superclass : #BlElement,
	#instVars : [
		'roassalCanvas',
		'elementListener'
	],
	#category : #'Roassal3-Bloc-Core'
}

{ #category : #'instance creation' }
RSCanvasElement class >> newWithCanvas: aRSCanvas [

	^ self basicNew
		  initializeWithCanvas: aRSCanvas;
		  yourself
]

{ #category : #initialization }
RSCanvasElement >> initializeWithCanvas: aRSCanvas [

	self initialize.

	roassalCanvas := aRSCanvas.
	elementListener := RSBlocEventListener newForCanvas: aRSCanvas.
	
	self
		background: aRSCanvas color;
		addAnimation: self newInfiniteCanvasAnimation;
		addEventHandler: elementListener;
		when: BlElementExtentChangedEvent
			do: [ :evt | aRSCanvas extent: evt source extent ];
		constraintsDo:[ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		syncSignalUpdateFirstTime.

]

{ #category : #'refreshing - private' }
RSCanvasElement >> newCameraElement [
	"Answer a BlElement that has as children the representation of the regular RSShapes of a RSCanvas. 
	These are the regular shapes, that must be translated and scaled according to the camera."

	^ (RSCameraElement newWithCanvas: roassalCanvas)
		addChildren: self newRegularShapeElements;
		yourself
]

{ #category : #'refreshing - private' }
RSCanvasElement >> newFixedShapeElements [
	"Answer a collection of BlElement instances that represent the #fixedShapes. The fixedShapes of a RSCanvas are shapes that are not affected by camera transformations. They are useful for toolbar buttons or legends, for example."

	^ roassalCanvas fixedShapes collect: [ :each | each asBlElement ]
]

{ #category : #'refreshing - private' }
RSCanvasElement >> newInfiniteCanvasAnimation [
	"Answer a new Bloc animation that infinitely runs any available Roassal animation (in the canvas)."

	^ BlNumberTransition new
		from: 0; to: 1;
		onStepDo: [ :t | 
			roassalCanvas playAnimations ];
		beInfinite;
		yourself.
]

{ #category : #'refreshing - private' }
RSCanvasElement >> newRegularShapeElements [
	"Answer a collection of BlElement instances that represent the regular RSShapes of a RSCanvas. These are the regular shapes, that must be translated and scaled according to the camera."

	^ roassalCanvas shapes collect: [ :each | each asBlElement ]
]

{ #category : #accessing }
RSCanvasElement >> roassalShape [

	^ roassalCanvas
]

{ #category : #refreshing }
RSCanvasElement >> signalUpdate [
	"Request a redraw on the canvas. 
	
	Note 1: 
	The redraw is not executed immediately/syncronously but instead, it's enqueued as a task in the mainElement. There are two cases then:
	- If the mainElement has already been added as a child in a BlSpace, the task will be run in next universe pulse. 
	- If it wasn't added to a space, the task will be enqueued in an internal BlTaskQueue until the element is added as a child in a BlSpace, and then first option will have course.

	Note 2:	
	As an optimization, multiple signalUpdate requests may be converted as a single redraw."


	self syncSignalUpdateSecondTimeAndLater.

	"Skip if the request is already done."
"	signalUpdateRequested ifTrue: [ ^ self ].
	signalUpdateRequested := true.
	
	self enqueueTask: (BlTaskAction new
			 action: [ 
				 self syncSignalUpdate.
				 signalUpdateRequested := false ];
			 yourself)
"

]

{ #category : #refreshing }
RSCanvasElement >> syncSignalUpdateFirstTime [

	| cameraElement fixedElements |
	cameraElement := self newCameraElement.
	fixedElements := self newFixedShapeElements.

	self
		addChild: cameraElement;
		addChildren: fixedElements;
		allChildrenBreadthFirstDo: [ :each |
			self flag: #todo. "Workaround until camera element is converted into a layout "
			each == cameraElement ifFalse: [
				each addEventHandler: elementListener] ].
		
	roassalCanvas
		when: RSShapeAddedEvent do: [ :evt |
			| newChild |
			newChild := evt shape asBlElement.
			newChild withAllChildrenBreadthFirstDo: [ :each |
				each addEventHandler: elementListener].
			self addChild: newChild ];
		when: RSShapeRemovedEvent do: [ :evt | 
			self
				allChildrenBreadthFirstDetect: [ :each |
					each roassalShape == evt shape ]
				ifFound: [ :element | element removeFromParent ]
				ifNone: [ #syncSignalUpdateFirstTime traceCr. ] ].

]

{ #category : #refreshing }
RSCanvasElement >> syncSignalUpdateSecondTimeAndLater [

	self updateFromRoassalShape
]
