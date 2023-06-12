Extension { #name : #RSCircularAroundAVertexLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSCircularAroundAVertexLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberField new
			label: 'Center Index';
			selector: #centerIndex;
			yourself);
		yourself
]
