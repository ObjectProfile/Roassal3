Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space',
		'elementListener'
	],
	#category : #'Roassal3-Bloc-Core'
}

{ #category : #accessing }
RSBlocHost >> defaultWindowTitle [

	^ super defaultWindowTitle , ' - Bloc'
]

{ #category : #opening }
RSBlocHost >> newCanvasElement [
	"The shapes of a RSCanvas must be translated and scaled according to the camera."

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
	"The fixedShapes of a RSCanvas are not affected by camera transformations. This is useful for toolbar buttons or legends, for example."

	^ canvas fixedShapes collect: [ :each | 
		  each asBlElement
			  addEventHandler: elementListener;
			  yourself ]
]

{ #category : #opening }
RSBlocHost >> newInfiniteCanvasAnimation [

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

	elementListener := RSBlocEventListener newForHost: self.

	space := BlSpace new
		extent: canvas extent;
		title: aTitleAsString;
		yourself.

	self signalUpdate.

	space root
		background: canvas color;
		addAnimation: self newInfiniteCanvasAnimation;
		addEventHandler: elementListener.

	space
		when: BlSpaceResizedEvent
		do: [ :evt | canvas extent: evt extent ].

	space show.

	^ space

]

{ #category : #opening }
RSBlocHost >> signalUpdate [
	"Removes everything and re-adds fresh."

	space ifNil: [ ^ self ].
	space root
		removeChildren;
		addChild: self newCanvasElement;
		addChild: self newFixedShapesElement

]

{ #category : #accessing }
RSBlocHost >> space [

	^ space
]
