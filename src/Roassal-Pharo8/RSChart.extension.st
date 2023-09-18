Extension { #name : #RSChart }

{ #category : #'*Roassal-Pharo8' }
RSChart >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite Roassal
		title: ['Canvas'];
		initializeCanvas: [ self build; canvas ]
		
]
