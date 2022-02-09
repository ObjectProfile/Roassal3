Class {
	#name : #RSbSpline,
	#superclass : #RSPolyline,
	#instVars : [
		'param',
		'points'
	],
	#category : #'Roassal3-Shapes-Lines'
}

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
