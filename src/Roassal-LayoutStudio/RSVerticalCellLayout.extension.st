Extension { #name : 'RSVerticalCellLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSVerticalCellLayout class >> alignmentOptions [
	^ #(left center right none)
]

{ #category : '*Roassal-LayoutStudio' }
RSVerticalCellLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
