Extension { #name : #RSAbstractGridLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractGridLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Gap size';
			selector: #gapSize;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Line items count';
			selector: #lineItemsCount;
			yourself);
		yourself
]
