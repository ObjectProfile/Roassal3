Extension { #name : #RSRTreeShapeCollection }

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorQueries [
	<inspectorPresentationOrder: 4 title: 'Queries'>
	^ root inspectorQueries
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorQueriesContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorRectangles [
	<inspectorPresentationOrder: 1 title: 'Rectangles'>
	^ self root inspectorRectangles
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorRectanglesContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorTree [
	<inspectorPresentationOrder: 3 title: 'Tree'>
	^ root inspectorTree
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorTreeContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorWithParent [
	<inspectorPresentationOrder: 2 title: 'With Parent'>
	^ root inspectorWithParent
]

{ #category : #'*Roassal-Inspector' }
RSRTreeShapeCollection >> inspectorWithParentContext: aContext [
	aContext withoutEvaluator
]
