Extension { #name : #TSShape }

{ #category : #'*Roassal3-Inspector' }
TSShape >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Shape'];
		initializeView: [ self gtViewForInspector ].
		
]

{ #category : #'*Roassal3-Inspector' }
TSShape >> gtViewForInspector [
	| view copy |
	view := RSView new.
	copy := self copy.
	view addShape: copy.
	view @ RSChessBackground.
	^ view
]
