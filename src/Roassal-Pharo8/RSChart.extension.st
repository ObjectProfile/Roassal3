Extension { #name : #RSChart }

{ #category : #'*Roassal3-Pharo8' }
RSChart >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self build; canvas ]
		
]
