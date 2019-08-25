"
demo class
"
Class {
	#name : #RSCollectionOfPackages,
	#superclass : #Object,
	#instVars : [
		'name',
		'packages'
	],
	#category : #'Roassal3-Grapher-Foo'
}

{ #category : #hooks }
RSCollectionOfPackages >> applyMetric: aBlockClosure [ 
	^ self packages inject: 0 into: [ :sum :pkg | (aBlockClosure value: pkg)+sum ].
]

{ #category : #building }
RSCollectionOfPackages >> buildOn: aPlot [ 
	| ellipse label |
	ellipse := TSEllipse new
		color: Color blue;
		size: 10;
		position: (aPlot positionFor: self);
		yourself.
	aPlot view addShape: ellipse.
	label := TSLabel new
		color: Color black;
		text: self name;
		yourself.
	aPlot view addShape: label.
	RSLocation new
		outer; top;
		move: label on: ellipse.
]

{ #category : #'initailize-release' }
RSCollectionOfPackages >> initializeWith: aString [ 
	name := aString.
	packages := RPackage organizer packages select: [ :pkg |
		pkg name beginsWith: aString ].
	 
]

{ #category : #accessing }
RSCollectionOfPackages >> name [
	^ name
]

{ #category : #accessing }
RSCollectionOfPackages >> packages [
	^ packages
]
