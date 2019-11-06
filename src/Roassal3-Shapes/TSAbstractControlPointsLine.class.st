"
I am an abstract class for lines with control points
"
Class {
	#name : #TSAbstractControlPointsLine,
	#superclass : #TSAbstractLine,
	#instVars : [
		'controlPoints',
		'markers',
		'controlPointsBlock'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #actions }
TSAbstractControlPointsLine >> basicTranslateBy: delta [
	controlPoints := controlPoints collect: [:p | p + delta ].
]

{ #category : #accessing }
TSAbstractControlPointsLine >> controlPoints [
	^ controlPoints ifNil: [ #() ].
]

{ #category : #accessing }
TSAbstractControlPointsLine >> controlPoints: anArrayOfPoints [
	controlPoints := anArrayOfPoints collect: #asFloatPoint.
	self resetPath.
]

{ #category : #accessing }
TSAbstractControlPointsLine >> controlPointsBlock [
	^ controlPointsBlock
]

{ #category : #accessing }
TSAbstractControlPointsLine >> controlPointsBlock: aBlockOrValue [
	controlPointsBlock := aBlockOrValue
]

{ #category : #accessing }
TSAbstractControlPointsLine >> endPoint [
	^ self controlPoints last
]

{ #category : #accessing }
TSAbstractControlPointsLine >> endPoint: aPoint [
	self controlPoints 
		at: self controlPoints size
		put: aPoint.
	self resetPath.
]

{ #category : #testing }
TSAbstractControlPointsLine >> isControlPointsLine [
	^ true
]

{ #category : #'accessing - markers' }
TSAbstractControlPointsLine >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #'accessing - markers' }
TSAbstractControlPointsLine >> privateMarkers [
	^ markers
]

{ #category : #accessing }
TSAbstractControlPointsLine >> startPoint [
	^ self controlPoints first
]

{ #category : #accessing }
TSAbstractControlPointsLine >> startPoint: aPoint [
	self controlPoints at: 1 put: aPoint.
	self resetPath.
]

{ #category : #update }
TSAbstractControlPointsLine >> update [
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
