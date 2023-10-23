Extension { #name : 'RSBoundingShape' }

{ #category : '*Roassal-Inspector' }
RSBoundingShape >> inspectorShadowFor: padding color: aColor [
	| m rect |
	rect := self baseRectangle expandBy: padding.
	m := self matrix copy.
	^ RSBox new
		extent: rect extent;
		matrix: m;
		color: aColor;
		cornerRadius: padding * 0.75;
		yourself
]
