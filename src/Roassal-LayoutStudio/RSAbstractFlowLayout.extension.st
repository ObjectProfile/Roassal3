Extension { #name : 'RSAbstractFlowLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSAbstractFlowLayout class >> alignmentOptions [
	^ self subclassResponsibility
]

{ #category : '*Roassal-LayoutStudio' }
RSAbstractFlowLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberField new
			label: 'Maximum width';
			selector: #maxWidth;
			yourself);
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
