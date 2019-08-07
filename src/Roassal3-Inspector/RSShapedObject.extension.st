Extension { #name : #RSShapedObject }

{ #category : #'*Roassal3-Inspector' }
RSShapedObject >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'Element';
		initializeView: [ self shape gtViewForInspector ]
]
