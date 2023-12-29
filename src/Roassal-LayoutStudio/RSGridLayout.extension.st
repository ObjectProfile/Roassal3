Extension { #name : 'RSGridLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSGridLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Vertical Aligment';
			items: self verticalAlignmentOptions;
			selector: #verticalAlignment;
			yourself);
		add: (RSLayoutChooseField new
			label: 'Horizontal Aligment';
			items: self horizontalAlignmentOptions;
			selector: #horizontalAlignment;
			yourself);
		yourself
]

{ #category : '*Roassal-LayoutStudio' }
RSGridLayout class >> verticalAlignmentOptions [
	^ #(top middle bottom)
]
