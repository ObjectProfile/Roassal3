Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space'
	],
	#category : #'Roassal3-Bloc'
}

{ #category : #opening }
RSBlocHost >> newElementForShape: aShape [

	^ BlElement new
		  relocate: aShape position + ((canvas extent - aShape extent) / 2);
		  geometry: BlRectangleGeometry new;
"		  border: (BlBorder paint: Color black width: 1);"
		  background: aShape paint;
		  size: aShape extent;
		  yourself
]

{ #category : #opening }
RSBlocHost >> newMainBlocElement [

	| children |
	children := canvas shapes collect: [:each |
		self newElementForShape: each ].


"
			translateBy: (self extent / 2) asFloatPoint;
			scaleBy: camera scale asFloat;
			translateBy: camera position negated asFloatPoint.
"	

	^ RSCanvasElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
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
	space root background: (canvas color).
	space show.
	^ space

]
