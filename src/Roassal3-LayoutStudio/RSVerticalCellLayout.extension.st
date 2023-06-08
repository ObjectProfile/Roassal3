Extension { #name : #RSVerticalCellLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSVerticalCellLayout classSide >> alignmentOptions [
	^ #(left center right none)
]

{ #category : #'*Roassal3-LayoutStudio' }
RSVerticalCellLayout classSide >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
