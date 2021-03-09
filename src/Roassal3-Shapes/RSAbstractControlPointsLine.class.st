"
I am an abstract class for lines with control points
"
Class {
	#name : #RSAbstractControlPointsLine,
	#superclass : #RSAbstractLine,
	#instVars : [
		'controlPoints',
		'controlPointsController'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #testing }
RSAbstractControlPointsLine class >> isAbstract [
	^ self =  RSAbstractControlPointsLine
]

{ #category : #actions }
RSAbstractControlPointsLine >> basicTranslateBy: delta [
	controlPoints := controlPoints collect: [:p | p + delta ].
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPoints [
	^ controlPoints ifNil: [ controlPoints := { 0@0. 0@0 } ].
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPoints: anArrayOfPoints [
	controlPoints := anArrayOfPoints collect: #asFloatPoint.
	self resetPath.
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPointsController [
	^ controlPointsController
]

{ #category : #accessing }
RSAbstractControlPointsLine >> controlPointsController: aCPController [
	controlPointsController := aCPController
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
RSAbstractControlPointsLine >> privateMarkers [
	^ markers ifNil: [ markers := Array new: 3 ].
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
	controlPointsController ifNil: [ ^ self ].
	self
		controlPoints: (controlPointsController controlPointsFor: self);
		notifyExtentChanged.
]
