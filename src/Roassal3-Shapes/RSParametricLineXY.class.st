Class {
	#name : #RSParametricLineXY,
	#superclass : #RSParametricLine,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #'as yet unclassified' }
RSParametricLineXY >> controlPoints: aSequenceableOfPoints at: t [

	^ (x value: t) @ (y value: t)
]

{ #category : #accessing }
RSParametricLineXY >> scale: factor [

	^ self newLine
		  x: [ :t | (x value: t) * factor ]
		  y: [ :t | (y value: t) * factor ];
		  yourself
]

{ #category : #'instance creation' }
RSParametricLineXY >> x: xBlock y: yBlock [

	x := xBlock.
	y := yBlock.

	self controlPoints: {  }
]
