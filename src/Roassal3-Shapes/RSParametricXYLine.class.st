Class {
	#name : #RSParametricXYLine,
	#superclass : #RSParametricLine,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #'as yet unclassified' }
RSParametricXYLine >> controlPoints: aSequenceableOfPoints at: t [

	^ (x value: t) @ (y value: t)
]

{ #category : #'instance creation' }
RSParametricXYLine >> newLine [

	^ super newLine
		  parameterization: (RSLinspaceParameterization new
				   from: parameterization from
				   to: parameterization to
				   samples: parameterization size;
				   yourself);
		  yourself
]

{ #category : #accessing }
RSParametricXYLine >> notifyDesignPointsChanged [

	
]

{ #category : #accessing }
RSParametricXYLine >> scale: factor [

	^ self newLine
		  x: [ :t | (x value: t) * factor ]
		  y: [ :t | (y value: t) * factor ];
		  yourself
]

{ #category : #'instance creation' }
RSParametricXYLine >> x: xBlock y: yBlock [

	x := xBlock.
	y := yBlock.

	self controlPoints: {  }
]
