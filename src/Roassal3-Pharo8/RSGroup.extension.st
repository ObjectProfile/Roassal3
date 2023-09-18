Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Pharo8' }
RSGroup >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 0>
	
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ | canvas |
			canvas := RSCanvas new
				addShape: (RSComposite new
					shapes: self;
					yourself).
			canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
			canvas ]
		
]
