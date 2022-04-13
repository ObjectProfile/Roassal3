Class {
	#name : #RSParametricLine,
	#superclass : #RSPolyline,
	#instVars : [
		'param',
		'points',
		'pointsSize',
		'cumulativeArcLengths',
		'sandboxPoints'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #'as yet unclassified' }
RSParametricLine >> arcLength [

	^ cumulativeArcLengths last
]

{ #category : #accessing }
RSParametricLine >> arcLengthParameterized [

	^ RSArcLengthParametricLine new
		  cumulativeArcLengths: cumulativeArcLengths;
		  line: self;
		  controlPoints: points;
		  yourself
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

	pointsSize := aSequenceableOfPoints size.

	points := Array new: pointsSize.
	sandboxPoints := Array new: pointsSize.

	aSequenceableOfPoints withIndexDo: [ :each :index | 
		| aPoint |
		aPoint := each asFloatPoint.

		points at: index put: aPoint.
		sandboxPoints at: index put: aPoint ].

	self resetPath
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

{ #category : #'as yet unclassified' }
RSParametricLine >> designPoints [

	^ points
]

{ #category : #'instance creation' }
RSParametricLine >> newLine [

	^ self class new
		  param: param;
		  yourself
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
RSParametricLine >> param: anInterval [

	| size |
	param := anInterval.

	size := self paramSize.

	controlPoints := Array new: size.
	cumulativeArcLengths := FloatArray new: size
]

{ #category : #accessing }
RSParametricLine >> paramSize [

	^ param size
]

{ #category : #accessing }
RSParametricLine >> pointsSize [

	^ pointsSize
]

{ #category : #accessing }
RSParametricLine >> refreshSandboxPoints [

	sandboxPoints
		replaceFrom: 1
		to: pointsSize
		with: points
		startingAt: 1
]

{ #category : #accessing }
RSParametricLine >> resetPath [

	controlPoints ifNotNil: [ 
		| lastPoint arcLength |
		arcLength := 0.0.

		lastPoint := self controlPointsAt: param first.

		param withIndexDo: [ :t :index | 
			| aPoint |
			aPoint := self controlPointsAt: t.

			"`arcLength` receives the #+ in order to have a floating addition."
			arcLength := arcLength + (lastPoint distanceTo: aPoint).

			cumulativeArcLengths at: index put: arcLength.

			controlPoints at: index put: aPoint.

			lastPoint := aPoint ] ].

	super resetPath
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
