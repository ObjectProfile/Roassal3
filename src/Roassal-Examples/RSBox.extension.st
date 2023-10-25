Extension { #name : 'RSBox' }

{ #category : '*Roassal-Examples' }
RSBox class >> example [
	| box |
	box := self new.
	box extent: 100 asPoint.
	box cornerRadius: 10.
	box color: Color blue muchDarker.
	^ (Smalltalk tools inspector inspect: box) window
]
