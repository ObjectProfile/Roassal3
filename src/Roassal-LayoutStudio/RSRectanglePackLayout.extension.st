Extension { #name : 'RSRectanglePackLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSRectanglePackLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Gap';
			selector: #gap;
			yourself);
		add: (RSLayoutAngleField new
			label: 'Angle';
			selector: #preferredAngle;
			yourself);
		yourself
]
