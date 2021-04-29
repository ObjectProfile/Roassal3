Extension { #name : #AthensAffineTransform }

{ #category : #'*Roassal3-Bloc' }
AthensAffineTransform >> asBlMatrix [
	
	^ BlMatrix2D new
		x: x;
		y: y;
		shx: shx;
		shy: shy;
		sx: sx;
		sy: sy;
		yourself
]
