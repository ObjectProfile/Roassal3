Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space'
	],
	#category : #'Roassal3-Bloc'
}

{ #category : #opening }
RSBlocHost >> newMainBlocElement [

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
				translateBy: (canvas extent / 2) asFloatPoint;
				scaleBy: canvas camera scale asFloat;
				translateBy: canvas camera position negated asFloatPoint.
			 ];
		addChildren: children;
		yourself
]

{ #category : #opening }
RSBlocHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	space := BlSpace new
		addChild: self newMainBlocElement;
		extent: canvas extent;
		title: aTitleAsString;
		yourself.
	space root background: canvas color.
	space show.
	^ space

]
