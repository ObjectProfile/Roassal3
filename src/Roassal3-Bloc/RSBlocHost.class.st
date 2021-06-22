"
I'm a RSHost that represents a RSCanvas as BlElement instances, eventually in a BlSpace (window).
"
Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space',
		'elementListener',
		'signalUpdateRequested',
		'mainElement'
	],
	#category : #'Roassal3-Bloc-Core'
}

{ #category : #opening }
RSBlocHost >> createMainElement [

	elementListener := RSBlocEventListener newForHost: self.

	mainElement := BlElement new
		background: canvas color;
		addAnimation: self newInfiniteCanvasAnimation;
		addEventHandler: elementListener;
		when: BlElementExtentChangedEvent
			do: [ :evt | canvas extent: evt source extent ];
		constraintsDo:[ :c |
			c horizontal matchParent.
			c vertical matchParent ]
		yourself.

]

{ #category : #accessing }
RSBlocHost >> defaultWindowTitle [

	^ super defaultWindowTitle , ' - Bloc'
]

{ #category : #accessing }
RSBlocHost >> mainElement [

	^ mainElement ifNil: [ 
		self createMainElement.
		self signalUpdate.
		mainElement ]
]

{ #category : #opening }
RSBlocHost >> newCanvasElement [
	"Answer a collection of BlElement instances that represent the regular RSShapes of a RSCanvas. These are the regular shapes, that must be translated and scaled according to the camera."

	| children |
	children := canvas shapes collect: [:each | each asBlElement
		addEventHandler: elementListener;
		yourself ].

	^ BlElement new
"		border: (BlBorder paint: Color blue translucent width: 10);"
		clipChildren: false;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :aBuilder |
			aBuilder
				centerOrigin;
				translateBy: (canvas extent / 2) asFloatPoint;
				translateBy: canvas camera position negated asFloatPoint;
				scaleBy: canvas camera scale asFloat;
				yourself.
			 ];
		addChildren: children;
		yourself
]

{ #category : #opening }
RSBlocHost >> newFixedShapeElements [
	"Answer a collection of BlElement instances that represent the #fixedShapes. The fixedShapes of a RSCanvas are shapes that are not affected by camera transformations. They are useful for toolbar buttons or legends, for example."

	^ canvas fixedShapes collect: [ :each | 
		  each asBlElement
			  addEventHandler: elementListener;
			  yourself ]
]

{ #category : #opening }
RSBlocHost >> newInfiniteCanvasAnimation [
	"Answer a new Bloc animation that infinitely runs any available Roassal animation (in the canvas)."

	^ BlNumberTransition new
		from: 0; to: 1;
		onStepDo: [ :t | 
			canvas playAnimations ];
		beInfinite;
		yourself.
]

{ #category : #opening }
RSBlocHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	space := BlSpace new
		extent: canvas extent;
		title: aTitleAsString;
		yourself.

	space addChild: self mainElement.
	space show.

	^ space

]

{ #category : #opening }
RSBlocHost >> signalUpdate [
	"Request a redraw on the canvas. 
	
	Note 1: 
	The redraw is not executed immediately/syncronously but instead, it's enqueued as a task in the mainElement. There are two cases then:
	- If the mainElement has already been added as a child in a BlSpace, the task will be run in next universe pulse. 
	- If it wasn't added to a space, the task will be enqueued in an internal BlTaskQueue until the element is added as a child in a BlSpace, and then first option will have course.

	Note 2:	
	As an optimization, multiple signalUpdate requests may be converted as a single redraw."

	self flag: #todo. "Check if this check is still needed"
	mainElement ifNil: [ ^ self ].

	signalUpdateRequested := true.
	mainElement enqueueTask: (BlTaskAction new
			 action: [ 
				 signalUpdateRequested ifTrue: [ self syncSignalUpdate ].
				 signalUpdateRequested := false ];
			 yourself)
]

{ #category : #accessing }
RSBlocHost >> space [
	"Answer the BlSpace where the the canvas has been opened. If it wasn't opened, the answer is nil."

	^ space
]

{ #category : #opening }
RSBlocHost >> syncSignalUpdate [
	"Removes everything and re-adds fresh."

	self flag: #todo.
	mainElement allChildrenDepthFirstDo: [ :each | 
		each removeEventHandler: elementListener ].

	mainElement
		removeChildren;
		addChild: self newCanvasElement;
		addChildren: self newFixedShapeElements
]
