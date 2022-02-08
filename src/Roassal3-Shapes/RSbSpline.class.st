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

	| n associations |
	n := aCollectionOfPoints size.

	associations := aCollectionOfPoints collect: [ :each | 
		                each asReflexiveAssociation ].

	points := Array new: param size.

	param withIndexDo: [ :t :index | 
		1 to: n do: [ :k | 
			1 to: n - k do: [ :i | 
				| aPoint nextPoint |
				aPoint := 1 - t * (associations at: i) value.
				nextPoint := t * (associations at: i + 1) value.
				(associations at: i) value: aPoint + nextPoint ] ].

		points at: index put: (associations at: 1) value.

		associations := aCollectionOfPoints collect: [ :each | 
			                each asReflexiveAssociation ] ].

	^ super controlPoints: points
]

{ #category : #'accessing - structure variables' }
RSbSpline >> samples: n [

	param := (0 to: 1) linspace: n
]
