Extension { #name : 'RSAngleLineLayout' }

{ #category : '*Roassal3-LayoutStudio' }
RSAngleLineLayout class >> alignmentOptions [
	^ #(none)
]

{ #category : '*Roassal3-LayoutStudio' }
RSAngleLineLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutAngleField new
			label: 'Angle';
			selector: #angle;
			yourself);
		yourself
]
