Extension { #name : #RSAbstractLine }

{ #category : #'*Roassal3-Inspector' }
RSAbstractLine >> inspectorShadowFor: padding color: aColor [

	^ self copy
		properties: nil;
		border: (RSBorder new
			color: aColor;
			width: self border width + padding;
			capRound;
			joinRound;
			yourself);
		yourself
]
