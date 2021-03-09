"
`RSArrowedLine` describes a line with a head or marker. 

Here is an example:

```
| c from to l |
c := RSCanvas new.

from := RSBox new size: 30.
to := RSEllipse new size: 30.

from @ RSDraggable.
to @ RSDraggable.

c add: from.
c add: to.

l := RSArrowedLine new.
l attachPoint: RSCenteredAttachPoint new.
l from: from.
l to: to.
c add: l.

to translateBy: 50 @ 40.

c @ RSCanvasController.
c open
```

Adding single line can be complex in some situation. You may want to look at RSLineBuilder arrowedLine
"
Class {
	#name : #RSArrowedLine,
	#superclass : #RSLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #border }
RSArrowedLine >> border: aRSBorder [
	super border: aRSBorder.
	self markersDo: [ :m | m shape border: aRSBorder ].
]

{ #category : #copying }
RSArrowedLine >> copy [
	| copy head |
	copy := super copy.
	head := copy markerEnd shape.
	copy markerEnd: self markerEnd copy.
	copy markerEnd shape: head.
	^ copy
]

{ #category : #initialization }
RSArrowedLine >> defaultHead [
	^ RSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		border: self border;
		yourself
]

{ #category : #initialization }
RSArrowedLine >> initialize [
	super initialize.
	self markerEnd: self defaultHead.
]

{ #category : #copying }
RSArrowedLine >> postCopy [
	super postCopy.
	markers := nil.
	self markerEnd: self defaultHead.
	self border: self border copy.
]
