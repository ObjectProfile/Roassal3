Extension { #name : #RSAbstractRegularTreeLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSAbstractRegularTreeLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutBooleanField new
			label: 'Should be Horizontally Reversed';
			selector: #shouldBeHorizontallyReversed);
		add: (RSLayoutBooleanField new
			label: 'Should be Vertically Reversed';
			selector: #shouldBeVerticallyReversed);
		add: (RSLayoutNumberField new
			label: 'Top';
			selector: #topGap);
		add: (RSLayoutNumberField new
			label: 'Left';
			selector: #leftGap);
		yourself
]
