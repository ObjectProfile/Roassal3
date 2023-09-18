Extension { #name : #RSForceBasedLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSForceBasedLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutBooleanField new
			label: 'Autorepulse';
			selector: #autoRepulse;
			yourself);
		add: (RSLayoutBooleanField new
			label: 'Use progress bar';
			selector: #shouldUseProgressBar;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Iterations';
			selector: #iterations;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Gravity';
			selector: #gravity;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Friction';
			selector: #friction;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Theta';
			selector: #theta;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Strength';
			selector: #strength;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Length';
			selector: #length;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Charge';
			selector: #charge;
			yourself);
		add: (RSLayoutPointField new
			label: 'Center';
			selector: #center;
			yourself);
		yourself
]
