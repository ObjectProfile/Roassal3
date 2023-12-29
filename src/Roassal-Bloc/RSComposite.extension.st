Extension { #name : #RSComposite }

{ #category : #'*Roassal-Bloc' }
RSComposite >> asBlElement [

	| aContainer |
	aContainer :=
		(RSCompositeElement newWith: self)
			geometry: self asBlGeometry;
			updateFromRoassalShape;
			yourself.

	self children do: [ :each |
		| newChild |
		newChild := each asBlElement.
		self flag: #todo. "This smells bad: is it repositioned correctly on a change?"
		newChild position: newChild position + (self baseRectangle extent / 2).
		aContainer addChild: newChild ].

	^ aContainer
]

{ #category : #'*Roassal-Bloc' }
RSComposite >> asBlGeometry [

	^ BlRectangleGeometry new
]
