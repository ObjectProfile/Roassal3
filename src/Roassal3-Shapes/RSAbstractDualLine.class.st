"
I am an abtract shape that has an start and one end
"
Class {
	#name : #RSAbstractDualLine,
	#superclass : #RSAbstractLine,
	#instVars : [
		'startPoint',
		'endPoint'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #transforming }
RSAbstractDualLine >> basicTranslateBy: delta [
	self translateBy: delta
]

{ #category : #accessing }
RSAbstractDualLine >> controlPoints [ 
	^ Array with: self startPoint with: self endPoint
]

{ #category : #accessing }
RSAbstractDualLine >> endPoint [
	^ endPoint
]

{ #category : #accessing }
RSAbstractDualLine >> endPoint: point [
	endPoint := point.
	self resetPath.
	self notifyExtentChanged.
]

{ #category : #initialization }
RSAbstractDualLine >> initialize [
	super initialize.
	startPoint := 0@0.
	endPoint := 100@100.
]

{ #category : #transforming }
RSAbstractDualLine >> position [
	^ self encompassingRectangle rsCenter
]

{ #category : #accessing }
RSAbstractDualLine >> startPoint [ 
	^ startPoint
]

{ #category : #accessing }
RSAbstractDualLine >> startPoint: point [
	startPoint := point.
	self resetPath
]

{ #category : #transforming }
RSAbstractDualLine >> translateBy: delta [
	self
		startPoint: startPoint + delta;
		endPoint: endPoint + delta.
	self resetPath
]

{ #category : #transforming }
RSAbstractDualLine >> translateTo: delta [
	| center |
	center := (startPoint + endPoint ) /2.
	self translateBy: delta - center
]

{ #category : #update }
RSAbstractDualLine >> update [
	self 
		startPoint: (attachPoint startingPointOf: self);
		endPoint: (attachPoint endingPointOf: self);
		notifyExtentChanged.
]
