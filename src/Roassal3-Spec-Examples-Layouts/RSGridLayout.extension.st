Extension { #name : #RSGridLayout }

{ #category : #'*Roassal3-Spec-Examples-Layouts' }
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

{ #category : #'*Roassal3-Spec-Examples-Layouts' }
RSGridLayout class >> verticalAlignmentOptions [
	^ #(top middle bottom)
]
