"
I am an abstract class for lines with control points
"
Class {
	#name : #RSAbstractControlPointsLine,
	#superclass : #RSAbstractLine,
	#instVars : [
		'controlPoints',
		'markers',
		'controlPointsBlock'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #actions }
RSAbstractControlPointsLine >> basicTranslateBy: delta [
	controlPoints := controlPoints collect: [:p | p + delta ].
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPoints [
	^ controlPoints ifNil: [ #() ].
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPoints: anArrayOfPoints [
	controlPoints := anArrayOfPoints collect: #asFloatPoint.
	self resetPath.
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPointsBlock [
	^ controlPointsBlock
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPointsBlock: aBlockOrValue [
	controlPointsBlock := aBlockOrValue
]

{ #category : #accessing }
RSAbstractControlPointsLine >> endPoint [
	^ self controlPoints last
]

{ #category : #accessing }
RSAbstractControlPointsLine >> endPoint: aPoint [
	self controlPoints 
		at: self controlPoints size
		put: aPoint.
	self resetPath.
]

{ #category : #testing }
RSAbstractControlPointsLine >> isControlPointsLine [
	^ true
]

{ #category : #'accessing - markers' }
RSAbstractControlPointsLine >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #'accessing - markers' }
RSAbstractControlPointsLine >> privateMarkers [
	^ markers
]

{ #category : #accessing }
RSAbstractControlPointsLine >> startPoint [
	^ self controlPoints first
]

{ #category : #accessing }
RSAbstractControlPointsLine >> startPoint: aPoint [
	self controlPoints at: 1 put: aPoint.
	self resetPath.
]

{ #category : #update }
RSAbstractControlPointsLine >> update [
	| cp |
	controlPointsBlock ifNil: [ ^ self ].
	cp := controlPointsBlock isCollection ifTrue: [  
		controlPointsBlock collect: [ :anObject | | v |
			v := anObject value.
			v isShape ifTrue: [ v := v position ].
			v ].
	] ifFalse: [ 
		controlPointsBlock 
			value: (attachPoint startingPointOf: self)
			value: (attachPoint endingPointOf: self)
	].
	self controlPoints: cp; notifyExtentChanged.
]
