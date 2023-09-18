Extension { #name : #ASContainerElement }

{ #category : #'*Roassal-SVG-Importer' }
ASContainerElement >> asShape [
	| shapes com |
	shapes := children collect: #asShape thenSelect: #notNil.
	com := RSComposite new.
	com children: shapes.
	self transform 
		ifNotNil: [ :t | com matrix: t ].
	^ com
]
