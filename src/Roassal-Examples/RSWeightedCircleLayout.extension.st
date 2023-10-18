Extension { #name : 'RSWeightedCircleLayout' }

{ #category : '*Roassal-Examples' }
RSWeightedCircleLayout class >> example1 [
	| v elements |
	v := RSCanvas new.
	elements := RSCircle models: (1 to: 15).
	elements do: [ :each | each size: each model * 4; color: Color red ].
	v addAll: elements.
	self on: elements.
	v @ RSCanvasController.
	^ v open
]
