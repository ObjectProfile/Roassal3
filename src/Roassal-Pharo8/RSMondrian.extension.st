Extension { #name : #RSMondrian }

{ #category : #'*Roassal-Pharo8' }
RSMondrian >> gtInspectorViewIn: composite [

	<gtInspectorPresentationOrder: -10>
	composite Roassal
		title: [ 'Canvas' ];
		initializeCanvas: [ self build; canvas ]
]
