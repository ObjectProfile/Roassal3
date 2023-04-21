Extension { #name : #RSCircularAroundAVertexLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSCircularAroundAVertexLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberField new
			label: 'Center Index';
			selector: #centerIndex;
			yourself);
		yourself
]
