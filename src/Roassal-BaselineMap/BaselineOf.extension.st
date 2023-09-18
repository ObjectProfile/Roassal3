Extension { #name : #BaselineOf }

{ #category : #'*Roassal-BaselineMap' }
BaselineOf >> inspectionBaselineMap [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := RSBaselineMapSettings classMapBuilder new
		baseline: self class;
		build;
		canvas.

	^ SpRoassalInspectorPresenter new
		canvas: canvas;
		yourself
]
