Class {
	#name : #RSbSpline,
	#superclass : #RSPolyline,
	#instVars : [
		'param',
		'points'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSbSpline >> asShapeWithControlNet [

	^ self asShapeWithControlNet: [ :bspline :circles :line |  ]
]

{ #category : #converting }
RSbSpline >> asShapeWithControlNet: aBlock [

	| circles polyline |
	polyline := RSPolyline new
		            controlPoints: points;
		            dotted;
		            yourself.

	circles := points withIndexCollect: [ :each :index | 
		           RSCircle new
			           model: each;
			           color: Color transparent;
			           radius: polyline border width * 2;
			           position: each;
			           when: RSPositionChangedEvent do: [ :ev | 
				           points at: index put: ev newPosition.
				           polyline controlPoints: points.
				           self controlPoints: points ];
			           draggable;
			           labeled;
			           withBorder;
			           yourself ].

	polyline color: polyline color translucent.
	self color: self color translucent.

	aBlock value: self value: circles value: polyline.

	^ RSComposite new
		  shapes: circles , { 
					  polyline.
					  self };
		  yourself
]

{ #category : #converting }
RSbSpline >> asShapeWithControlNetColoured: aColor [

	^ self asShapeWithControlNet: [ :bspline :circles :line | 
		  bspline color: aColor.
		  line color: aColor translucent.
		  circles do: [ :each | each color: aColor translucent ] ]
]

{ #category : #accessing }
RSbSpline >> controlPoints: aCollectionOfPoints [

	| n workingPoints |
	n := aCollectionOfPoints size.

	param ifNil: [ self samples: n * 10 ].

	workingPoints := Array new: param size.

	points := aCollectionOfPoints.

	param withIndexDo: [ :t :index | 
		| triple |
		triple := self deCasteljau: points copy at: t.

		workingPoints at: index put: triple first ].

	^ super controlPoints: workingPoints
]

{ #category : #accessing }
RSbSpline >> deCasteljau: workingPoints at: t [

	| n diagonal last |
	n := workingPoints size.

	diagonal := Array new: n.
	last := Array new: n.

	diagonal at: 1 put: workingPoints first.
	last at: 1 put: workingPoints last.

	1 to: n do: [ :k | 
		1 to: n - k do: [ :i | 
			| aPoint nextPoint |
			aPoint := 1 - t * (workingPoints at: i).
			nextPoint := t * (workingPoints at: i + 1).
			workingPoints at: i put: aPoint + nextPoint ].

		k < n ifTrue: [ 
			diagonal at: k + 1 put: workingPoints first.
			last at: k + 1 put: (workingPoints at: n - k) ] ].

	^ Array with: workingPoints first with: diagonal with: last
]

{ #category : #accessing }
RSbSpline >> increment [

	| incremented n sandbox |
	n := points size.

	sandbox := Array new: n + 2.

	sandbox
		replaceFrom: 2
		to: n + 1
		with: points
		startingAt: 1.

	sandbox
		at: 1 put: 0 @ 0;
		at: n + 2 put: 0 @ 0.

	incremented := Array new: n + 1.

	1 to: n + 1 do: [ :i | 
		| t |
		t := i - 1 / n.

		incremented
			at: i
			put: t * (sandbox at: i) + (1 - t * (sandbox at: i + 1)) ].

	^ self class new
		  controlPoints: incremented;
		  yourself
]

{ #category : #'accessing - structure variables' }
RSbSpline >> samples: n [

	param := (0 to: 1) linspace: n
]

{ #category : #accessing }
RSbSpline >> splitAt: aParam in: aBlock [

	| triple left right |
	triple := self deCasteljau: points copy at: (aParam min: 1 max: 0).

	left := self class new
		        controlPoints: triple second;
		        yourself.

	right := self class new
		         controlPoints: triple third;
		         yourself.

	^ aBlock value: left value: right value: self
]
