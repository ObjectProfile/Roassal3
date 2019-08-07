Extension { #name : #RSView }

{ #category : #'*Roassal3-Inspector' }
RSView >> gtInspectorEdgesIn: composite [
	<gtInspectorPresentationOrder: 21>
	composite table
		when: [ self edges isNotEmpty ];
		title: 'Edges';
		showOnly: 50;
		display: [ :each | each edges ];
		column: 'Shape' evaluated: [ :each | each shape asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Attributes' evaluated: [ :each | each privateAttributes asString ].
]

{ #category : #'*Roassal3-Inspector' }
RSView >> gtInspectorElementsIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Elements';
		showOnly: 50;
		display: [ :each | each elements ];
		children: #children;
		column: 'Shape' evaluated: [ :each | each shape asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Attributes' evaluated: [ :each | each privateAttributes asString ].
]

{ #category : #'*Roassal3-Inspector' }
RSView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['View'];
		initializeView: [ self ]
		
]
