Extension { #name : 'RTreeCollection' }

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorQueries [
	<inspectorPresentationOrder: 4 title: 'Queries'>
	^ root inspectorQueries
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorQueriesContext: aContext [
	aContext withoutEvaluator
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorRectangles [
	<inspectorPresentationOrder: 1 title: 'Rectangles'>
	^ self root inspectorRectangles
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorRectanglesContext: aContext [
	aContext withoutEvaluator
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorTree [
	<inspectorPresentationOrder: 3 title: 'Tree'>
	^ root inspectorTree
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorTreeContext: aContext [
	aContext withoutEvaluator
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorWithParent [
	<inspectorPresentationOrder: 2 title: 'With Parent'>
	^ root inspectorWithParent
]

{ #category : '*Roassal-Inspector' }
RTreeCollection >> inspectorWithParentContext: aContext [
	aContext withoutEvaluator
]
