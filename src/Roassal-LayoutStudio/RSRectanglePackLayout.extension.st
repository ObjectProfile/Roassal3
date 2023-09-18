Extension { #name : #RSRectanglePackLayout }

{ #category : #'*Roassal3-LayoutStudio' }
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
