"
This layout uses an angle to describe a line where the elements would be placed
"
Class {
	#name : #RSAngleLineLayout,
	#superclass : #RSAbstractLineLayout,
	#instVars : [
		'angle',
		'originalPointer'
	],
	#category : #'Roassal-Layouts-Line'
}

{ #category : #accessing }
RSAngleLineLayout >> angle [
	^ angle
]

{ #category : #accessing }
RSAngleLineLayout >> angle: anAngleInDegrees [
	angle := anAngleInDegrees
]

{ #category : #accessing }
RSAngleLineLayout >> angleByDegrees: aFloat [
	self angle: aFloat degreesToRadians
	
]

{ #category : #hook }
RSAngleLineLayout >> defaultAngle [
	^ 0
]

{ #category : #defaults }
RSAngleLineLayout >> defaultPosition [
	^ 0 @ 0
	
]

{ #category : #hook }
RSAngleLineLayout >> deltaFor: anRSShape [
	^ 0@0
]

{ #category : #initialization }
RSAngleLineLayout >> initialize [
	super initialize.
	self 
		angle: self defaultAngle;
		originalPointer: self defaultPosition
	
]

{ #category : #hook }
RSAngleLineLayout >> movePointer: pointer accordingToFigure: anRSShape [
	| x y vector normal unit gap |
	x := angle cos.
	y := angle sin.
	vector := x @ y * anRSShape extent.
	normal := vector normal.
	unit := vector / (vector r max: 1).
	gap := unit * self gapSize.
	^ pointer + vector + gap.
]

{ #category : #accessing }
RSAngleLineLayout >> originalPointer [

	^ originalPointer
]

{ #category : #accessing }
RSAngleLineLayout >> originalPointer: anObject [

	originalPointer := anObject
]

{ #category : #hook }
RSAngleLineLayout >> positionOriginalPointer: shapes [ 
	^ originalPointer
]
