Extension { #name : #TSCanvas }

{ #category : #'*Roassal3-Inspector' }
TSCanvas >> gtInspectorShapesIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Shapes';
		showOnly: 50;
		display: [ :each | each shapes ];
		children: #shapes;
		column: 'Shape' evaluated: [ :each | each asString ];
		column: 'Paint' evaluated: [ :each | each paint asString ];
		column: 'Border' evaluated: [ :each | each border asString ].
]

{ #category : #'*Roassal3-Inspector' }
TSCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeView: [ 
			view ifNil: [ RSView new
				setCanvas: self;
				yourself ] ]
		
]
