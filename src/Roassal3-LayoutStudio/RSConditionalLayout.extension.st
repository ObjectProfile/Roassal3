Extension { #name : 'RSConditionalLayout' }

{ #category : '*Roassal3-LayoutStudio' }
RSConditionalLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutEvalField new
			label: 'If';
			selector: #if;
			yourself);
		add: (RSLayoutPickerField new
			label: 'Then layout';
			selector: #then;
			yourself);
		add: (RSLayoutPickerField new
			label: 'Else layout';
			selector: #else;
			yourself);
		add: (RSLayoutPickerField new
			label: 'Cluster layout';
			selector: #clusterLayout;
			yourself);
		yourself
]
