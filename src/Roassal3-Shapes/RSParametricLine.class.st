Class {
	#name : #RSParametricLine,
	#superclass : #RSPolyline,
	#instVars : [
		'points',
		'pointsSize',
		'cumulativeArcLengths',
		'sandboxPoints',
		'parameterization',
		'overlappingControlPointsDistance'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSParametricLine >> arcLengthParameterization [

	self parameterization: RSArcLengthParameterization new
]

{ #category : #converting }
RSParametricLine >> asGroupWithControlNet [

	^ self asGroupWithControlNetColoured: Color gray
]

{ #category : #converting }
RSParametricLine >> asGroupWithControlNet: aBlock [

	| circles polyline labels location |
	polyline := RSPolyline new
		            controlPoints: points;
		            dotted;
		            yourself.

	circles := Array new: pointsSize.
	labels := Array new: pointsSize.

	location := RSLocation new
		            above;
		            yourself.

	points withIndexCollect: [ :each :index | 
		| circle label |
		circle := RSCircle new
			          model: each;
			          color: Color transparent;
			          radius: polyline border width * Float goldenPlatinumRatio;
			          draggable;
			          withBorder;
			          position: each;
			          yourself.

		label := RSLabel new
			         useDefaultCodeFont;
			         text: (circle position asFloatPointRound: 3);
			         yourself.

		location stick: label on: circle.

		circle when: RSPositionChangedEvent do: [ :ev | 
			circle model: ev newPosition.
			label text: (ev newPosition asFloatPointRound: 3).

			points at: index put: ev newPosition.
			polyline controlPoints: points.

			self controlPoints: points ].


		circles at: index put: circle.
		labels at: index put: label ].

	polyline color: polyline color translucent.
	self color: self color translucent.

	aBlock
		value: self
		value: circles
		value: labels
		value: polyline.

	^ RSGroup new
		  addAll: circles , labels , { 
					  polyline.
					  self };
		  yourself
]

{ #category : #converting }
RSParametricLine >> asGroupWithControlNetColoured: aColor [

	^ self asGroupWithControlNet: [ :bspline :circles :labels :line | 
		  | translucentColor |
		  translucentColor := aColor translucent.

		  bspline color: aColor.
		  line color: translucentColor.
		  circles with: labels do: [ :circle :label | 
			  circle border color: translucentColor.
			  label color: translucentColor ] ]
]

{ #category : #accessing }
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

{ #category : #converting }
RSParametricLine >> controlPoints: aSequenceableOfPoints at: t [

	self subclassResponsibility
]

{ #category : #accessing }
RSParametricLine >> controlPointsAt: t [

	self refreshSandboxPoints.

	^ (self controlPoints: sandboxPoints at: t) asFloatPoint
]

{ #category : #accessing }
RSParametricLine >> controlPointsSize [

	^ pointsSize
]

{ #category : #'as yet unclassified' }
RSParametricLine >> designPoints [

	^ points
]

{ #category : #initialization }
RSParametricLine >> initialize [

	super initialize.

	self capRound
]

{ #category : #'instance creation' }
RSParametricLine >> newLine [

	^ self class new
]

{ #category : #accessing }
RSParametricLine >> notifyDesignPointsChanged [

	self subclassResponsibility
]

{ #category : #'event handling' }
RSParametricLine >> notifyExtentChanged [

	self announce: [ 
		RSExtentChangedEvent new
			shape: self;
			oldExtent: nil;
			newExtent: (Rectangle encompassing: self controlPoints) extent ]
]

{ #category : #accessing }
RSParametricLine >> overlappingControlPointsDistance [

	^ overlappingControlPointsDistance
]

{ #category : #'as yet unclassified' }
RSParametricLine >> parameterization [

	^ parameterization
]

{ #category : #accessing }
RSParametricLine >> parameterization: anObject [

	anObject parameterize_RSParametricLine: self
]

{ #category : #accessing }
RSParametricLine >> parameterized_RSArcLengthParameterization: aParameterization [

	parameterization := aParameterization
		                    parameterization: parameterization;
		                    yourself.

	self
		refreshControlPoints;
		resetPath
]

{ #category : #accessing }
RSParametricLine >> parameterized_RSIntervalParameterization: aParameterization [

	parameterization := aParameterization
]

{ #category : #accessing }
RSParametricLine >> refreshControlPoints [

	parameterization withIndexDo: [ :t :index | 
		| aPoint |
		aPoint := self controlPointsAt: t.
		controlPoints at: index put: aPoint.

		"Ensure to return the point on the curve."
		aPoint ]
]

{ #category : #accessing }
RSParametricLine >> refreshSandboxPoints [

	sandboxPoints
		replaceFrom: 1
		to: pointsSize
		with: points
		startingAt: 1
]

{ #category : #converting }
RSParametricLine >> reversed [

	^ self newLine
		  controlPoints: points reversed;
		  yourself
]

{ #category : #accessing }
RSParametricLine >> scale: factor [

	^ self newLine
		  controlPoints: (points collect: [ :each | each * factor ]);
		  yourself
]
