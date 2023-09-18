Extension { #name : #RSAbstractLineLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSAbstractLineLayout class >> alignmentOptions [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-LayoutStudio' }
RSAbstractLineLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
