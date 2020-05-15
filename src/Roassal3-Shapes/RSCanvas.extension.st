Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Shapes' }
RSCanvas >> asShape [
	| g |
	g := self shapes copy.
	g do: #remove.
	^ RSComposite new
		shapes: g;
		yourself.
	
]
