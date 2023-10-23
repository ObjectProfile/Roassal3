"
I can return the control points for vertical lines

```
v := RSCanvas new.
	
	e1 := RSBox new size: 100; color: Color blue.
	e2 := RSBox new size: 100; color: Color red.
	e1 translateTo: 100 @ -200.

	e1 @ RSDraggable.
	e2 @ RSDraggable.
	v
		add: e1;
		add: e2.
	
	l := RSBezier new
		withVerticalAttachPoint;
		from: e1;
		to: e2;
		controlPointsController: (RSVerticalCPAPController new);
		yourself.
	v add: l.
	v open
```
"
Class {
	#name : 'RSVerticalCPAPController',
	#superclass : 'RSAbstractCPAPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'hooks' }
RSVerticalCPAPController >> controlPointsFrom: from to: to [
	| mid |
	mid := (from + to)/2.
	^ Array
		with: from
		with: from x @ mid y
		with: to x @ mid y
		with: to
]
