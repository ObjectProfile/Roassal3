"
I am an abstract class for lines with control points
"
Class {
	#name : #TSAbstractControlPointsLine,
	#superclass : #TSAbstractLine,
	#instVars : [
		'controlPoints',
		'markers'
	],
	#category : #'Roassal3-Shape'
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
