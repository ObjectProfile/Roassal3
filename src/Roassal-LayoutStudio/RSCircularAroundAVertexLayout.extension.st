Extension { #name : 'RSCircularAroundAVertexLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSCircularAroundAVertexLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberField new
			label: 'Center Index';
			selector: #centerIndex;
			yourself);
		yourself
]
