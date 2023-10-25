Extension { #name : 'RSConditionalLayout' }

{ #category : '*Roassal-Examples' }
RSConditionalLayout class >> createCanvas [
	| classes shapes c eb |
	classes := Collection allSubclasses.
	shapes := classes collect: [ :class | RSBox new size: 10; model: class ] as: RSGroup.

	c := RSCanvas new.
	c addAll: shapes.
	eb := RSEdgeBuilder orthoVertical.
	eb canvas: c.
	eb withVerticalAttachPoint.
	eb shapes: shapes.
	eb connectFrom: #superclass.
	c @ RSCanvasController.
	^ c
]

{ #category : '*Roassal-Examples' }
RSConditionalLayout class >> exampleCollection [
	| c |
	c := self createCanvas.
	self new
		ifNotConnectedThen: RSGridLayout new;
		else: RSTreeLayout new;
		on: c nodes.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSConditionalLayout class >> exampleCollection2 [
	| c |
	c := self createCanvas.

	self new
		ifConnectedThen: RSTreeLayout new;
		else: RSGridLayout new;
		clusterLayout: (RSVerticalLineLayout new
			alignCenter;
			gapSize: 20);
		on: c nodes.
	^ c open
]
