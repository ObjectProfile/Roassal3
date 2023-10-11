Extension { #name : 'RSStrokeStyle' }

{ #category : '*Roassal3-Bloc' }
RSStrokeStyle >> blApplyOn: aBlBorderBuilder [ 
	aBlBorderBuilder
		lineJoin: self blLineJoin
]

{ #category : '*Roassal3-Bloc' }
RSStrokeStyle >> blLineJoin [
	joinStyle = #joinRound
		ifTrue: [ ^ BlStrokeLineJoin round ].
	joinStyle = #joinMiter
		ifTrue: [ ^ BlStrokeLineJoin miter ].
	joinStyle = #joinBevel
		ifTrue: [ ^ BlStrokeLineJoin bevel ].
	^ self error: 'not supported'.
]
