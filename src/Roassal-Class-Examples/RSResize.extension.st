Extension { #name : #RSResize }

{ #category : #'*Roassal-Class-Examples' }
RSResize class >> example [
	| values canvas colorPallete boxes |
	values := #(35 26 5 18 17 60 36 13 16 28 29 3 8 0 3 2 14 12 13 17 1 9 3 3 4 1 1 1 2 1 1 61).
	canvas := RSCanvas  new.
	colorPallete := NSScale category20c.
	boxes := RSBox models: values.
	boxes size: #yourself.
	boxes color: colorPallete.
	canvas addAll: boxes.
	"before this all of them have different sizes"
	self new shapes: boxes; sameSize.
	
	RSHorizontalLineLayout new gapSize: 0; on: boxes.
	canvas @ RSCanvasController.
	^ canvas open
]
