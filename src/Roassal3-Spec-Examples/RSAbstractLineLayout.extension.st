Extension { #name : #RSAbstractLineLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractLineLayout class >> alignmentOptions [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractLineLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]
