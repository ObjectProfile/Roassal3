Extension { #name : 'RSAngleLineLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSAngleLineLayout class >> alignmentOptions [
	^ #(none)
]

{ #category : '*Roassal-LayoutStudio' }
RSAngleLineLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutAngleField new
			label: 'Angle';
			selector: #angle;
			yourself);
		yourself
]
