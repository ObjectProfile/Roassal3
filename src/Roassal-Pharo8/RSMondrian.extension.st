Extension { #name : #RSMondrian }

{ #category : #'*Roassal3-Pharo8' }
RSMondrian >> gtInspectorViewIn: composite [

	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: [ 'Canvas' ];
		initializeCanvas: [ self build; canvas ]
]
