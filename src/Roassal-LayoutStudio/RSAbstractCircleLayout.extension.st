Extension { #name : 'RSAbstractCircleLayout' }

{ #category : '*Roassal-LayoutStudio' }
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
			help: 'If one field is zero, then it will use the scale factor to compute its value';
			yourself);
		add: (RSLayoutPointField new
			label: 'Central Point';
			selector: #centerPoint;
			yourself);
		yourself
]
