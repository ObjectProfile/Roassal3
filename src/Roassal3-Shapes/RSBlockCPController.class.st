"
I have am useful to define the control points in a fast way, but if you plan to use this controller in many scenarios, try to create a new subclass of RSAbstractCPController and avoid to use this class

```
canvas := RSCanvas new.
 
box1 := RSBox new color: Color blue.
box2 := RSBox new color: Color red.
box2 translateTo: 100 @ -200.

box1 @ RSDraggable.
box2 @ RSDraggable.
canvas add: box1; add: box2.
 
bezierLine := RSBezier new
	withVerticalAttachPoint;
	from: box1;
	to: box2;
	controlPointsController: (
			RSBlockCPController new
				block: [ :aLine |
					| mid |
   					mid := (box1 position + box2 position) / 2.
					{(box1 position) . 
					(box1 position x @ mid y) .
					(box2 position x @ mid y) .
					(box2 position)} ];
				yourself);
  yourself.
canvas add: bezierLine.
canvas zoomToFit.
canvas open
```
"
Class {
	#name : #RSBlockCPController,
	#superclass : #RSAbstractCPController,
	#instVars : [
		'block'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #accessing }
RSBlockCPController >> block [
	^ block
]

{ #category : #accessing }
RSBlockCPController >> block: aBlockClosure [
	block := aBlockClosure
]

{ #category : #hooks }
RSBlockCPController >> controlPointsFor: aLine [
	^ block cull: aLine
]
