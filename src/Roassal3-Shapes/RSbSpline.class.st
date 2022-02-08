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

	| n |
	n := aCollectionOfPoints size.

	param ifNil: [ self samples: n * 10 ].

	points := Array new: param size.

	param withIndexDo: [ :t :index | 
		| workingPoints |
		workingPoints := aCollectionOfPoints copy.

		1 to: n do: [ :k | 
			1 to: n - k do: [ :i | 
				| aPoint nextPoint |
				aPoint := 1 - t * (workingPoints at: i).
				nextPoint := t * (workingPoints at: i + 1).
				workingPoints at: i put: aPoint + nextPoint ] ].

		points at: index put: (workingPoints at: 1) ].

	^ super controlPoints: points
]

{ #category : #'accessing - structure variables' }
RSbSpline >> samples: n [

	param := (0 to: 1) linspace: n
]
