Class {
	#name : 'RSParametricLine',
	#superclass : 'RSPolyline',
	#instVars : [
		'points',
		'pointsSize',
		'sandboxPoints',
		'parameterization',
		'overlappingControlPointsDistance'
	],
	#category : 'Roassal3-Shapes-Lines',
	#package : 'Roassal3-Shapes',
	#tag : 'Lines'
}

{ #category : 'testing' }
RSParametricLine class >> isAbstract [

	^ true
]

{ #category : 'accessing' }
RSParametricLine >> arcLengthParameterization [

	self parameterization: RSArcLengthParameterization new
]

{ #category : 'converting' }
RSParametricLine >> asGroupWithControlNet [

	^ self asGroupWithControlNetColoured: Color gray
]

{ #category : 'accessing' }
RSParametricLine >> controlPoints: aSequenceableOfPoints [

	| lastPoint |
	pointsSize := aSequenceableOfPoints size.

	points := Array new: pointsSize.
	sandboxPoints := Array new: pointsSize.

	overlappingControlPointsDistance := 0.0.
	lastPoint := aSequenceableOfPoints
		             ifEmpty: [ nil ]
		             ifNotEmpty: [ aSequenceableOfPoints first ].

	aSequenceableOfPoints withIndexDo: [ :each :index | 
		| aPoint |
		aPoint := each asFloatPoint.

		overlappingControlPointsDistance := overlappingControlPointsDistance
		                                    + (lastPoint distanceTo: each).
		lastPoint := each.

		points at: index put: aPoint.
		sandboxPoints at: index put: aPoint ].

	self notifyDesignPointsChanged.

	controlPoints := Array new: parameterization size.

	self
		refreshControlPoints;
		resetPath
]

{ #category : 'converting' }
RSParametricLine >> controlPoints: aSequenceableOfPoints at: t [

	self subclassResponsibility
]

{ #category : 'accessing' }
RSParametricLine >> controlPointsAt: t [

	self refreshSandboxPoints.

	^ (self controlPoints: sandboxPoints at: t) asFloatPoint
]

{ #category : 'accessing' }
RSParametricLine >> controlPointsSize [

	^ pointsSize
]

{ #category : 'accessing' }
RSParametricLine >> designPoints [

	^ points
]

{ #category : 'initialization' }
RSParametricLine >> initialize [

	super initialize.

	self capRound
]

{ #category : 'instance creation' }
RSParametricLine >> newLine [

	^ self class new
]

{ #category : 'accessing' }
RSParametricLine >> notifyDesignPointsChanged [

	self subclassResponsibility
]

{ #category : 'event handling' }
RSParametricLine >> notifyExtentChanged [

	self announce: [ 
		RSExtentChangedEvent new
			shape: self;
			oldExtent: nil;
			newExtent: (Rectangle encompassing: self controlPoints) extent ]
]

{ #category : 'accessing' }
RSParametricLine >> overlappingControlPointsDistance [

	^ overlappingControlPointsDistance
]

{ #category : 'accessing' }
RSParametricLine >> parameterization [

	^ parameterization
]

{ #category : 'accessing' }
RSParametricLine >> parameterization: anObject [

	anObject parameterize_RSParametricLine: self
]

{ #category : 'accessing' }
RSParametricLine >> parameterized_RSArcLengthParameterization: aParameterization [

	parameterization := aParameterization
		                    parameterization: parameterization;
		                    yourself.

	self
		refreshControlPoints;
		resetPath
]

{ #category : 'accessing' }
RSParametricLine >> parameterized_RSIntervalParameterization: aParameterization [

	parameterization := aParameterization
]

{ #category : 'accessing' }
RSParametricLine >> refreshControlPoints [

	parameterization withIndexDo: [ :t :index | 
		| aPoint |
		aPoint := self controlPointsAt: t.
		controlPoints at: index put: aPoint.

		"Ensure to return the point on the curve."
		aPoint ]
]

{ #category : 'accessing' }
RSParametricLine >> refreshSandboxPoints [

	sandboxPoints
		replaceFrom: 1
		to: pointsSize
		with: points
		startingAt: 1
]

{ #category : 'converting' }
RSParametricLine >> reversed [

	^ self newLine
		  controlPoints: points reversed;
		  yourself
]

{ #category : 'accessing' }
RSParametricLine >> scale: factor [

	^ self newLine
		  controlPoints: (points collect: [ :each | each * factor ]);
		  yourself
]
