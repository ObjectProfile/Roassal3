"
TODO
"
Class {
	#name : #TSAbstractCircleLayout,
	#superclass : #TSLayout,
	#instVars : [
		'initialAngle',
		'initialIncrementalAngle',
		'initialRadius',
		'factor'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
TSAbstractCircleLayout class >> isAbstract [
	^ self name = #TSAbstractCircleLayout
]

{ #category : #hook }
TSAbstractCircleLayout >> computeIncrementalAngleFor: elements [
	"Return the value _in radian_ of the incremental angle"
	
	^ initialIncrementalAngle = 0
		ifTrue: [ 2 * Float pi / elements size ]
		ifFalse: [ initialIncrementalAngle ]
]

{ #category : #hook }
TSAbstractCircleLayout >> computeRadiusFor: elements [
	"Return the radius of the circle. If none has been set (i.e., initialRadius = 0), then it is computed as the scale factor times the number of elements"
	^ initialRadius = 0 
		ifTrue: [ elements size * self scaleFactor ]
		ifFalse: [ initialRadius ]
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialAngle [
	"Return the initial angle, in radian"
	^ initialAngle
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialAngle: aFloat [
	"aFloat is an angle in Radian."
	initialAngle := aFloat
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialAngleInDegree [ 
	"Return the initial angle in degree"
	^ self initialAngle * 180 / Float pi
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialAngleInDegree: aNumber [
	"Set the initial angle in radian"
	self initialAngle: aNumber * Float pi / 180
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialIncrementalAngle [
	"Return the initial incremental angle"
	^ initialIncrementalAngle
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialIncrementalAngle: aNumberInRadian [
	initialIncrementalAngle := aNumberInRadian
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialIncrementalAngleInDegree: aNumberInDegree [
	self initialIncrementalAngle: aNumberInDegree * Float pi / 180
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialRadius [
	"Return the radius in pixels of the circle"
	^ initialRadius
]

{ #category : #accessing }
TSAbstractCircleLayout >> initialRadius: aNumber [
	"Set the radius of the circle"
	initialRadius := aNumber
]

{ #category : #'initialize-release' }
TSAbstractCircleLayout >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."
	
	super initialize.
	self scaleBy: 11.
	
	"Represent the initial angle to place the elements"
	initialAngle := 0.
	
	"Distance of the circle. If it is 0 when entering doExecute, then it is computed"
	initialRadius := 0.
	
	"0 means that it is computed, and not set by the user"
	initialIncrementalAngle := 0.
]

{ #category : #accessing }
TSAbstractCircleLayout >> radius: aNumber [
	^ self initialRadius: aNumber
]

{ #category : #accessing }
TSAbstractCircleLayout >> scaleBy: aNumber [
	
	factor := aNumber
]

{ #category : #accessing }
TSAbstractCircleLayout >> scaleFactor [
	^ factor
]
