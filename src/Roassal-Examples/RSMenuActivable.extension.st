Extension { #name : 'RSMenuActivable' }

{ #category : '*Roassal-Examples' }
RSMenuActivable class >> example [
	| m |

	m := RSCanvas new.
	m addAll: ((1 to: 10) collect: [:each | | label |
		label := RSLabel new
			text: each asString;
			yourself.
		{ label } asShape
			padding: 5;
			model: each;
			color: Color white;
			borderColor: Color black;
			yourself
		]).
	RSGridLayout on: m nodes.
	m @ RSCanvasController.
	m nodes @ (self new
		menuDo: [ :menu :shape |
			menu
				add: 'Inspect'
				target: shape model
				selector: #inspect ]).

	^ m open
]
