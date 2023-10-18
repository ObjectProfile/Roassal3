Extension { #name : 'RSEquidistantCircleLayout' }

{ #category : '*Roassal-Examples' }
RSEquidistantCircleLayout class >> example1 [

	| v elements |
	v := RSCanvas new.

	elements := RSCircle models: (1 to: 15).
	elements do: [ :each | each color: Color red; size: each model * 4 ].
	v addAll: elements.
	self on: elements.
	v @ RSCanvasController.
	^ v open
]
