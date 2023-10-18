Extension { #name : 'RSLine' }

{ #category : '*Roassal-Examples' }
RSLine class >> exampleFMT [
	| line |
	line := self new.
	line startPoint: 0@0.
	line endPoint: 200@100.
	line color: Color black.
	line width: 1.
	line format: '--^'.
	line markerEnd shape size: 20.
	^ RSCanvas new
		add: line;
		zoomToFit;
		open
]

{ #category : '*Roassal-Examples' }
RSLine class >> exampleLine [
	| line |
	line := self new.
	line startPoint: 0@0.
	line endPoint: 200@100.
	line color: Color black.
	line width: 10.
	line capRound.
	^ RSCanvas new
		add: line;
		open
]
