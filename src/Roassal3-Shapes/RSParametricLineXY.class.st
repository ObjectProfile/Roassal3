Class {
	#name : #RSParametricLineXY,
	#superclass : #RSParametricLine,
	#instVars : [
		'x',
		'y',
		'scale'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #'as yet unclassified' }
RSParametricLineXY >> controlPoints: aSequenceableOfPoints at: t [

	^ (x value: t) @ (y value: t) * scale
]

{ #category : #'instance creation' }
RSParametricLineXY >> x: xBlock y: yBlock [

	self x: xBlock y: yBlock scale: 1
]

{ #category : #'instance creation' }
RSParametricLineXY >> x: xBlock y: yBlock scale: aScale [

	x := xBlock.
	y := yBlock.
	scale := aScale.

	self controlPoints: {  }
]
