Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space'
	],
	#category : #'Roassal3-Bloc'
}

{ #category : #opening }
RSBlocHost >> newCanvasElement [

	| children |
	children := canvas shapes collect: [:each | each asBlElement ].

	^ RSCanvasElement new
"		  border: (BlBorder paint: Color black width: 1);	"
		clipChildren: false;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :aBuilder |
			aBuilder
				centerOrigin;
				translateBy: (canvas extent / 2) asFloatPoint;
				translateBy: canvas camera position negated asFloatPoint;
				scaleBy: canvas camera scale asFloat.
			 ];
		addChildren: children;
		yourself
]

{ #category : #opening }
RSBlocHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	space := BlSpace new
		addChild: self newCanvasElement;
		extent: canvas extent;
		title: aTitleAsString;
		yourself.

	space root
		background: canvas color;
		addEventHandler: (RSEventListener newForHost: self).

	space
		when: BlSpaceResizedEvent
		do: [ :evt | canvas extent: evt extent ].

	space show.
	^ space

]

{ #category : #opening }
RSBlocHost >> signalUpdate [

	space ifNil: [ ^ self ].
	space root
		removeChildren;
		addChild: self newCanvasElement
]
