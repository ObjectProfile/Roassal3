Extension { #name : 'RSPieSlice' }

{ #category : '*Roassal-Inspector' }
RSPieSlice >> inspectorShadowFor: padding color: aColor [
	| m rect |
	rect := self baseRectangle expandBy: padding.
	m := self matrix copy.
	^ self class new
		externalRadius: self externalRadius + padding;
		innerRadius: self innerRadius - padding;
		cornerRadii: self cornerRadii;
		alphaAngle: self alphaAngle;
		betaAngle: self betaAngle;
		segmentSpacing: -3;
		matrix: m;
		color: aColor;
		yourself
]
