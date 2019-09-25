Extension { #name : #RSAbstractViewBuilder }

{ #category : #'*Roassal3-Inspector' }
RSAbstractViewBuilder >> gtInspectorBuilderIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Builder'];
		initializeView: [ 
			self build.
			self view when: TSExtentChangedEvent do: [ self view zoomToFit ].
			self view.
			 ]
]
