Extension { #name : #RSAbstractGridLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractGridLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutEvalField new
			label: 'Line items count';
			selector: #lineItemsCount;
			yourself);
		yourself
]
