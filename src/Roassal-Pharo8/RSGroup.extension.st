Extension { #name : #RSGroup }

{ #category : #'*Roassal-Pharo8' }
RSGroup >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 0>
	
	composite Roassal
		title: ['Canvas'];
		initializeCanvas: [ | canvas |
			canvas := RSCanvas new
				addShape: (RSComposite new
					shapes: self;
					yourself).
			canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
			canvas ]
		
]
