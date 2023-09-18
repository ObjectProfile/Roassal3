Extension { #name : #RSComposite }

{ #category : #'*Roassal-Bloc' }
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

{ #category : #'*Roassal-Bloc' }
RSComposite >> asBlGeometry [

	^ BlRectangleGeometry new
]
