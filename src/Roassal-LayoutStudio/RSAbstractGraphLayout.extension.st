Extension { #name : 'RSAbstractGraphLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSAbstractGraphLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Horizontal gap size';
			selector: #horizontalGap;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Vertical gap size';
			selector: #verticalGap;
			yourself);
		yourself
]
