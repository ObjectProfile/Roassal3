Extension { #name : #RSVerticalLineLayout }

{ #category : #'*Roassal-Class-Examples' }
RSVerticalLineLayout class >> example1 [
	| c |
	c := self canvasExample.
	self on: c nodes.
	c zoomToFit.
	^ c open
]

{ #category : #'*Roassal-Class-Examples' }
RSVerticalLineLayout class >> example2 [
	| c |
	c := self canvasExample.
	self new
		alignRight;
		on: c nodes.
	c zoomToFit.
	^ c open
]
