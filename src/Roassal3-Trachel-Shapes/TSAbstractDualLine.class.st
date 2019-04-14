"
I am an abtract shape that has an start and one end
"
Class {
	#name : #TSAbstractDualLine,
	#superclass : #TSAbstractLine,
	#instVars : [
		'startPoint',
		'endPoint'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSAbstractDualLine >> controlPoints [ 
	^ Array with: self startPoint with: self endPoint
]

{ #category : #accessing }
TSAbstractDualLine >> endPoint [
	^ endPoint
]

{ #category : #accessing }
TSAbstractDualLine >> endPoint: point [
	endPoint := point.
	self resetPath.
	self notifyExtentChanged.
]

{ #category : #initialization }
TSAbstractDualLine >> initialize [
	super initialize.
	startPoint := 0@0.
	endPoint := 100@100.
]

{ #category : #accessing }
TSAbstractDualLine >> startPoint [ 
	^ startPoint
]

{ #category : #accessing }
TSAbstractDualLine >> startPoint: point [
	startPoint := point.
	self resetPath
]

{ #category : #transforming }
TSAbstractDualLine >> translateBy: delta [
	self
		startPoint: startPoint + delta;
		endPoint: endPoint + delta.
	self resetPath
]
