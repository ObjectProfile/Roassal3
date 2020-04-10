Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Inspector' }
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

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self ]
		
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorContext [
	^ self
		attributeAt: RSAbstractContext name asSymbol
		ifAbsentPut: [ RSInteractiveContext new ]
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorContext: aRSContext [
	^ self
		attributeAt: RSAbstractContext name asSymbol
		put: aRSContext
]
