"
TODO
"
Class {
	#name : #RSAbstractCircleLayout,
	#superclass : #RSLayout,
	#instVars : [
		'initialAngle',
		'initialIncrementalAngle',
		'initialRadius',
		'factor'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSAbstractCircleLayout class >> isAbstract [
	^ self name = #RSAbstractCircleLayout
]

{ #category : #hook }
RSAbstractCircleLayout >> computeIncrementalAngleFor: elements [
	"Return the value _in radian_ of the incremental angle"
	
	^ initialIncrementalAngle = 0
		ifTrue: [ 2 * Float pi / elements size ]
		ifFalse: [ initialIncrementalAngle ]
]

{ #category : #hook }
RSAbstractCircleLayout >> computeRadiusFor: elements [
	"Return the radius of the circle. If none has been set (i.e., initialRadius = 0), then it is computed as the scale factor times the number of elements"
	^ initialRadius = 0 
		ifTrue: [ elements size * self scaleFactor ]
		ifFalse: [ initialRadius ]
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialAngle [
	"Return the initial angle, in radian"
	^ initialAngle
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialAngle: aFloat [
	"aFloat is an angle in Radian."
	initialAngle := aFloat
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialAngleInDegree [ 
	"Return the initial angle in degree"
	^ self initialAngle * 180 / Float pi
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialAngleInDegree: aNumber [
	"Set the initial angle in radian"
	self initialAngle: aNumber * Float pi / 180
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialIncrementalAngle [
	"Return the initial incremental angle"
	^ initialIncrementalAngle
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialIncrementalAngle: aNumberInRadian [
	initialIncrementalAngle := aNumberInRadian
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialIncrementalAngleInDegree: aNumberInDegree [
	self initialIncrementalAngle: aNumberInDegree * Float pi / 180
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialRadius [
	"Return the radius in pixels of the circle"
	^ initialRadius
]

{ #category : #accessing }
RSAbstractCircleLayout >> initialRadius: aNumber [
	"Set the radius of the circle"
	initialRadius := aNumber
]

{ #category : #'initialize-release' }
RSAbstractCircleLayout >> initialize [
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
RSAbstractCircleLayout >> radius: aNumber [
	"Set the radius in pixels of the layout
```
nodes := (1 to: 5).

canvas := RSCanvas new.
shapes := RSCircle models: nodes.
shapes size: 30.
canvas addAll: shapes.

RSCircleLayout new radius: 20; on: shapes.
canvas @ RSCanvasController.
canvas 
```
	"
	^ self initialRadius: aNumber
]

{ #category : #accessing }
RSAbstractCircleLayout >> scaleBy: aNumber [
	factor := aNumber
]

{ #category : #accessing }
RSAbstractCircleLayout >> scaleFactor [
	^ factor
]
