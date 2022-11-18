Extension { #name : #RSShape }

{ #category : #'*Roassal3-Inspector' }
RSShape >> canvasForInspector [
	| canvas copy |
	canvas := RSCanvas new.
	copy := self copyWithoutAnnouncer.
	canvas addShape: copy.
	canvas @ RSChessBackgroundInteraction.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSShape >> inspectorShadowFor: padding color: aColor [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Inspector' }
RSShape >> inspectorShape [
	<inspectorPresentationOrder: 90 title: 'Shape'>

	^ SpRoassal3InspectorPresenter new
		canvas: self canvasForInspector;
		yourself
]
