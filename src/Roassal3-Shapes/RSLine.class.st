"
RSLine describes a line. A line typically links two shapes.

Here is an example:

-=-=-=-=
c := RSCanvas new.

from := RSBox new size: 30.
to := RSEllipse new size: 30.

from @ RSDraggable.
to @ RSDraggable.

c add: from.
c add: to.

l := RSLine new.
l attachPoint: RSCenteredAttachPoint new.
l from: from.
l to: to.
c add: l.

to translateBy: 50 @ 40.

c @ RSControlsCanvas.
c
-=-=-=-=

Adding single line can be complex in some situation. You may want to look at RSEdgeBuilder to ease the edge creation. 
"
Class {
	#name : #RSLine,
	#superclass : #RSAbstractDualLine,
	#classInstVars : [
		'delta'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSLine class >> delta [
	^ delta ifNil: [ delta := 5 ]
]

{ #category : #accessing }
RSLine class >> delta: aNumber [
	self assert: aNumber >= 0 description: 'The delta for TSLine can not be negative'.
	delta := aNumber
]

{ #category : #accessing }
RSLine class >> reset [
	<script: 'self reset'>
	delta := nil.
]

{ #category : #visiting }
RSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]

{ #category : #testing }
RSLine >> includesPoint: aPoint [
	^ aPoint
		onLineFrom: self startPoint 
		to: self endPoint 
		within: RSLine delta
	
]
