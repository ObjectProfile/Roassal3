Extension { #name : #BMBaselineModel }

{ #category : #'*Roassal3-BaselineMap' }
BMBaselineModel >> inspectionBaselineMap: builder [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := RSBaselineMapSettings classMapBuilder new
		in: [ :map |
			self baselineClass 
				ifNotNil: [ map baseline: self baselineClass ] ];
		build;
		canvas.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
