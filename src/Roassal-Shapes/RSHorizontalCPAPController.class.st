"
I can return the control points for horizontal lines

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
		controlPointsController: (RSHorizontalCPAPController new);
		yourself.
	v add: l.
	v open
```
"
Class {
	#name : 'RSHorizontalCPAPController',
	#superclass : 'RSAbstractCPAPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'hooks' }
RSHorizontalCPAPController >> controlPointsFrom: from to: to [
	| mid |
	mid := (from + to)/2.
	^ Array
		with: from
		with: mid x @ from y
		with: mid x @ to y
		with: to
]
