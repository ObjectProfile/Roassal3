Extension { #name : #RSTransitionAnimation }

{ #category : #'*Roassal3-Inspector' }
RSTransitionAnimation >> inspectorControls [

	<inspectorPresentationOrder: 0 title: 'Controls'>
	^ SpRSTransitionInspectorPresenter new
		  animation: self; 
		  yourself
]
