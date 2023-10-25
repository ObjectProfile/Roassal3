"
I use block for each segment
This class is just for examples and demos. For a better visitor for each segment try to create a new subclass of RSSegmentsVisitor
"
Class {
	#name : 'RSBlockSegmentsVisitor',
	#superclass : 'RSSegmentsVisitor',
	#instVars : [
		'lineToBlock',
		'curveViaAndToBlock',
		'moveToBlock',
		'closeBlock'
	],
	#category : 'Roassal-SVG-Segments',
	#package : 'Roassal-SVG',
	#tag : 'Segments'
}

{ #category : 'accessing' }
RSBlockSegmentsVisitor >> closeBlock: aBlockClosure [
	closeBlock := aBlockClosure
]

{ #category : 'accessing' }
RSBlockSegmentsVisitor >> curveViaAndToBlock: aBlockClosure [
	curveViaAndToBlock := aBlockClosure
]

{ #category : 'accessing' }
RSBlockSegmentsVisitor >> lineToBlock: aBlockClosure [
	lineToBlock := aBlockClosure
]

{ #category : 'accessing' }
RSBlockSegmentsVisitor >> moveToBlock: aBlockClosure [
	moveToBlock := aBlockClosure
]

{ #category : 'public' }
RSBlockSegmentsVisitor >> simplePoints: aBlock [

	| current first simplePoints |
	current := first := nil.
	simplePoints := [ :segment |
		aBlock value: segment value: current.
		current := segment endPoint.
		 ].
	self
		moveToBlock: [ :segment | current := first := segment point ];
		lineToBlock: simplePoints;
		curveViaAndToBlock: simplePoints;
		closeBlock: [:s |
			current = first ifFalse: [
				simplePoints value: (AthensLineSegment new point: first) ] ]
]

{ #category : 'visiting' }
RSBlockSegmentsVisitor >> visitCloseSegment: aSegment [
	closeBlock value: aSegment
]

{ #category : 'visiting' }
RSBlockSegmentsVisitor >> visitCubicSegment: aSegment [
	curveViaAndToBlock value: aSegment
]

{ #category : 'visiting' }
RSBlockSegmentsVisitor >> visitLineSegment: aSegment [
	lineToBlock value: aSegment
]

{ #category : 'visiting' }
RSBlockSegmentsVisitor >> visitMoveSegment: aSegment [
	moveToBlock value: aSegment
]

{ #category : 'visiting' }
RSBlockSegmentsVisitor >> visitQuadSegment: aSegment [
	lineToBlock value: aSegment
]
