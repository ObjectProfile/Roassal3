Extension { #name : 'RSSVGPathLine' }

{ #category : '*Roassal-Examples' }
RSSVGPathLine class >> exampleArc [
	| canvas line |
	canvas := RSCanvas new.
	line := self new.
	line borderColor: Color black.
	line paint: Color lightGray.
	line svgPath: [ :theLine | [ :pathBuilder |
		| radius center startAngle deltaAngle |
		radius := 60.
		startAngle := 45 degreesToRadians.
		deltaAngle := 90 degreesToRadians.
		center := 0@0.
		pathBuilder
			moveTo: (startAngle cos @ startAngle sin) * radius + center;
			arcCenterX: center x
			centerY: center y
			radius: radius
			startAngle: startAngle
			endAngle: startAngle + deltaAngle
		 ] ].
	canvas add: line.
	^ canvas open
]
