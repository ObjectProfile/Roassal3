Extension { #name : #RSRTreeShapeCollection }

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorQueries [
	<inspectorPresentationOrder: 4 title: 'Queries'>
	^ root inspectorQueries
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorQueriesContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorRectangles [
	<inspectorPresentationOrder: 1 title: 'Rectangles'>
	^ self root inspectorRectangles
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorRectanglesContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorTree [
	<inspectorPresentationOrder: 3 title: 'Tree'>
	^ root inspectorTree
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorTreeContext: aContext [
	aContext withoutEvaluator
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorWithParent [
	<inspectorPresentationOrder: 2 title: 'With Parent'>
	^ root inspectorWithParent
]

{ #category : #'*Roassal3-Inspector' }
RSRTreeShapeCollection >> inspectorWithParentContext: aContext [
	aContext withoutEvaluator
]
