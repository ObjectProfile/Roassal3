"
I am an abtract shape that has an start and one end, 2 control points.
My subclasses are `RSLine` and `RSSVGPathLine`


"
Class {
	#name : 'RSAbstractDualLine',
	#superclass : 'RSAbstractLine',
	#instVars : [
		'startPoint',
		'endPoint'
	],
	#category : 'Roassal-Shapes-Lines',
	#package : 'Roassal-Shapes',
	#tag : 'Lines'
}

{ #category : 'testing' }
RSAbstractDualLine class >> isAbstract [
	^ self = RSAbstractDualLine
]

{ #category : 'transforming' }
RSAbstractDualLine >> basicTranslateBy: delta [
	self translateBy: delta
]

{ #category : 'accessing' }
RSAbstractDualLine >> controlPoints [
	^ Array with: self startPoint with: self endPoint
]

{ #category : 'accessing' }
RSAbstractDualLine >> controlPoints: aCollection [
	self assert: aCollection size = 2 description: 'Should have two points.'.
	self startPoint: aCollection first; endPoint: aCollection second
]

{ #category : 'accessing' }
RSAbstractDualLine >> endPoint [
	^ endPoint
]

{ #category : 'accessing' }
RSAbstractDualLine >> endPoint: point [
	endPoint = point ifTrue: [ ^ self ].
	endPoint := point.
	self resetPath.
	self notifyExtentChanged
]

{ #category : 'initialization' }
RSAbstractDualLine >> initialize [
	super initialize.
	startPoint := 0@0.
	endPoint := 100@100
]

{ #category : 'transforming' }
RSAbstractDualLine >> invert [
	self controlPoints: ( self controlPoints collect: [ :p | p y @ p x ])
]

{ #category : 'accessing' }
RSAbstractDualLine >> position: aPoint [
	| position delta |
	position := self position.
	delta := aPoint - position.
	self
		startPoint: startPoint + delta;
		endPoint: endPoint  + delta;
		resetPath
]

{ #category : 'accessing' }
RSAbstractDualLine >> startPoint [
	^ startPoint
]

{ #category : 'accessing' }
RSAbstractDualLine >> startPoint: point [
	startPoint = point ifTrue: [ ^ self ].
	startPoint := point.
	self resetPath
]

{ #category : 'update' }
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
		notifyExtentChanged
]
