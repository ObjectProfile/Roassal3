Extension { #name : #RSClusteringLayout }

{ #category : #'*Roassal3-LayoutStudio' }
RSClusteringLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutPickerField new
			label: 'Clusters layout';
			selector: #clustersLayout;
			yourself);
		add: (RSLayoutPickerField new
			label: 'For each layout';
			selector: #forEachLayout;
			yourself);
		yourself
]
