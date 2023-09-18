Extension { #name : #RSRectangleForceLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSRectangleForceLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutNumberField new
			label: 'Enclosing threshold';
			selector: #enclosingThreshold;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Enclosing Force';
			selector: #enclosingForce;
			yourself);
		add: (RSLayoutRectangleField new
			label: 'Enclosing Rectangle';
			selector: #enclosingRectangle;
			yourself);
		yourself
]
