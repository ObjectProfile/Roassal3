Extension { #name : #BaselineOf }

{ #category : #'*Roassal3-BaselineMap' }
BaselineOf >> inspectionBaselineMap [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := RSBaselineMapSettings classMapBuilder new
		baseline: self class;
		build;
		canvas.

	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
