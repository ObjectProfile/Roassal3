Extension { #name : #RSAbstractFlowLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractFlowLayout class >> alignmentOptions [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Spec-Examples' }
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
