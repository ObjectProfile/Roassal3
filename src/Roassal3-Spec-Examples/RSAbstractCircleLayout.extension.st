Extension { #name : #RSAbstractCircleLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSAbstractCircleLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutAngleField new
			label: 'Initial Angle';
			selector: #initialAngle;
			yourself);
		add: (RSLayoutAngleField new
			label: 'Increment Angle';
			selector: #initialIncrementalAngle;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Initial Radius';
			selector: #initialRadius;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Scale Factor';
			selector: #scaleFactor;
			yourself);
		yourself
]
