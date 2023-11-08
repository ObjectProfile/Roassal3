Extension { #name : 'RSAbstractRegularTreeLayout' }

{ #category : '*Roassal-Mondrian' }
RSAbstractRegularTreeLayout class >> example1 [
	| b |
	b := RSMondrian new.
	b nodes: (1 to: 100).
	b lines connectFrom: [ :v | v // 2 ].
	b layout tree verticallyReverse.
	^ b open
]
