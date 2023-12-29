"
RSLine describes a line. This example shows how to create a line with basic properties

```
line := RSLine new.
line startPoint: 40@30.
line endPoint: 220@140.
line color: Color blue.
line width: 10.
line dashArray: #(8 4).
```
A line typically links two shapes. Here is an example:

```
| c from to l |
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

c @ RSCanvasController.
c
```

Adding single line can be complex in some situation. You may want to look at `RSLineBuilder` to ease the line creation.
To get more information read comment of `RSAbstractLine`
"
Class {
	#name : 'RSLine',
	#superclass : 'RSAbstractDualLine',
	#category : 'Roassal-Shapes-Lines',
	#package : 'Roassal-Shapes',
	#tag : 'Lines'
}

{ #category : 'testing' }
RSLine >> basicIncludesPoint: aPoint [
	^ aPoint
		onLineFrom: self startPoint
		to: self endPoint
		within: self includedRadius
]

{ #category : 'visiting' }
RSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]
