Extension { #name : #RSAbstractFlowLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractFlowLayout class >> alignmentOptions [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractFlowLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Maximum width';
			selector: #maxWidth;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Gap size';
			selector: #gapSize;
			yourself);
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
