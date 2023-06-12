Extension { #name : #RSComposite }

{ #category : #'*Roassal3-Bloc' }
RSComposite >> asBlElement [

	| container |
	container := super asBlElement
		clipChildren: false;	
		yourself.

	self children do: [:each |
		| newChild |
		newChild := each asBlElement.
		newChild position: newChild position + (self baseRectangle extent / 2).
		container addChild: newChild ].

	^ container
]

{ #category : #'*Roassal3-Bloc' }
RSComposite >> asBlGeometry [

	^ BlRectangleGeometry new
]
