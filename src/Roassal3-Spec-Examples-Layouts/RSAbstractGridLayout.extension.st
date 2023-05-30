Extension { #name : #RSAbstractGridLayout }

{ #category : #'*Roassal3-Spec-Examples-Layouts' }
RSAbstractGridLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutEvalField new
			label: 'Line items count';
			selector: #lineItemsCount;
			yourself);
		yourself
]
