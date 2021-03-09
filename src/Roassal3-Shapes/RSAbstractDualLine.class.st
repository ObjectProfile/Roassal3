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

{ #category : #testing }
RSAbstractDualLine class >> isAbstract [
	^ self = RSAbstractDualLine
]

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
	^ self encompassingRectangle floatCenter
]

{ #category : #private }
RSAbstractDualLine >> privateMarkers [
	^ markers ifNil: [ markers := Array new: 3 ].
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
	"Note that before calling this method, an attach point has to be set. Consider the following example:
```
b1 := RSBox new size: 20.
b2 := RSBox new size: 20.
b1 translateTo: 20 @ 30.
b2 translateTo: 40 @ 50.

l := RSLine new from: b1; to: b2.
l attachPoint: RSBorderAttachPoint new .
l update.
```

Removing the call to #attachPoint: raised an error
	"
	(attachPoint isNil | from isNil | to isNil) ifTrue: [ ^ self ].
	self
		startPoint: (attachPoint startingPointOf: self);
		endPoint: (attachPoint endingPointOf: self);
		notifyExtentChanged.
]
