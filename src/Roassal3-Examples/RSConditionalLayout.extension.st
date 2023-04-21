Extension { #name : #RSConditionalLayout }

{ #category : #'*Roassal3-Examples' }
RSConditionalLayout class >> exampleCollection [
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

	"RSTreeLayout on: shapes."
	self new
		ifNotConnectedThen: RSGridLayout new;
		else: RSTreeLayout new;
		on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : #'*Roassal3-Examples' }
RSConditionalLayout class >> exampleCollection2 [
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

	"RSTreeLayout on: shapes."
	self new
		ifConnectedThen: RSTreeLayout new;
		else: RSGridLayout new;
		on: shapes.
	c @ RSCanvasController.
	^ c open
]
