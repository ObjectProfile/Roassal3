Extension { #name : #RSCanvas }

{ #category : #'*Roassal-Pharo8' }
RSCanvas >> gtInspectorShapesIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Shapes';
		showOnly: 50;
		display: [ :each | each shapes ];
		children: #children;
		column: 'Shape' evaluated: [ :each | each asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Paint' evaluated: [ :each | each paint asString ];
		column: 'Border' evaluated: [ :each | each border asString ].
]

{ #category : #'*Roassal-Pharo8' }
RSCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite Roassal
		title: ['Canvas'];
		initializeCanvas: [ self ]
		
]
