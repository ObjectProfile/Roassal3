Extension { #name : 'RSAbstractBoxedLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSAbstractBoxedLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Gap size';
			selector: #gapSize;
			yourself);
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
