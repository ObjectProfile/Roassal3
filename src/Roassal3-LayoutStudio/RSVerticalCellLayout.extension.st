Extension { #name : #RSVerticalCellLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSVerticalCellLayout class >> alignmentOptions [
	^ #(left center right none)
]

{ #category : #'*Roassal3-LayoutStudio' }
RSVerticalCellLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
