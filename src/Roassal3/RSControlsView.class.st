"
I am experimental class.
Add to the view the next interactions
- RSZoomableView
- RSDraggableView
 
- RSMenuActivable
- RSZoomMove
- RSFocusOnCenterScaleMove

"
Class {
	#name : #RSControlsView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'mouse'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSControlsView >> onElement: aView [
	aView @ RSZoomableView.
	aView @ RSDraggableView.
	aView @ (RSMenuActivable new 
		menuDo: [:menu | 
			(menu 
				add: 'Zoom in'
				target: RSZoomMove in
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomIn).
			(menu 
				add: 'Zoom to fit'
				target: RSZoomToFitView new
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomToFit).
			(menu 
				add: 'Zoom out'
				target: RSZoomMove out
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomOut) ]).

	
]
