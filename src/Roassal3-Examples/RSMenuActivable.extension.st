Extension { #name : #RSMenuActivable }

{ #category : #'*Roassal3-Examples' }
RSMenuActivable class >> example [
	| m |
	m := RSMondrian new.
	m nodes: (1 to: 10).
	m build.
	"this creates an interaction for all the canvas nodes"
	m canvas nodes @ (self new
		menuDo: [ :menu :shape |
			menu
				add: 'Inspect'
				target: shape model
				selector: #inspect ]).

	^ m open
]
