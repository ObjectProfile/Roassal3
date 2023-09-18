Extension { #name : #RSCellLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSCellLayout class >> alignmentOptions [
	^ #(top middle bottom none)
]

{ #category : #'*Roassal3-LayoutStudio' }
RSCellLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
