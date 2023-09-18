Extension { #name : #RSAbstractGridLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSAbstractGridLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberOrBlockField new
			label: 'Line items count';
			selector: #lineItemsCount;
			yourself);
		yourself
]
