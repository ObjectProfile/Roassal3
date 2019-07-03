"
TODO
"
Class {
	#name : #RSOptimizedForceBasedLayout,
	#superclass : #RSForceBasedLayout,
	#instVars : [
		'mockElements',
		'mockEdges'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSOptimizedForceBasedLayout >> addEdges: realEdges [
	
	| newMockEdges |
	newMockEdges := realEdges collect: [ :e | self newMockEdgeFor: e ].

	mockEdges ifNil: [ mockEdges := OrderedCollection new ].
	mockEdges addAll: newMockEdges.
	super addEdges: newMockEdges.

]

{ #category : #hook }
RSOptimizedForceBasedLayout >> addNodes: realElements [

	| newMockElements |
	newMockElements := (realElements collect: [ :e | self newMockElementFor: e ]).

	super addNodes: newMockElements.
	
	mockElements ifNil: [ mockElements := OrderedCollection new ].
	mockElements addAll: newMockElements.
	
]

{ #category : #hook }
RSOptimizedForceBasedLayout >> executeOnElements: elements [
	"The argument is the set of Roassal elements"
	mockElements := elements collect: [ :e | self newMockElementFor: e ].
	super executeOnElements: mockElements.
	mockElements do: #applyToRealElement
]

{ #category : #'accessing - computed' }
RSOptimizedForceBasedLayout >> fix: realNode at: aPoint [
	super fix: (self mockElementAt: realNode) at: aPoint.
]

{ #category : #accessing }
RSOptimizedForceBasedLayout >> mockEdgeAt: anEdge [
	^ mockEdges detect: [ :each | each realEdge == anEdge ]
]

{ #category : #accessing }
RSOptimizedForceBasedLayout >> mockElementAt: realNode [
	^ mockElements detect: [ :each | each realElement == realNode ]
]

{ #category : #accessing }
RSOptimizedForceBasedLayout >> newMockEdgeFor: e [
	^ RSMockEdge new 
		from: (self mockElementAt: e from);
		to: (self mockElementAt: e to);
		realEdge: e;
		yourself
]

{ #category : #hook }
RSOptimizedForceBasedLayout >> newMockElementFor: e [
	^ RSMockElement new
		realElement: e;
		yourself
]

{ #category : #accessing }
RSOptimizedForceBasedLayout >> removeFix: aNode [
	super removeFix: (self mockElementAt: aNode)
]

{ #category : #'accessing - computed' }
RSOptimizedForceBasedLayout >> set: realEdge length: aNumber [
	super set: (self mockEdgeAt: realEdge) length: aNumber
]

{ #category : #accessing }
RSOptimizedForceBasedLayout >> setEdgesFromElements: elements [
	| view realElements realEdges |
	elements isEmpty ifTrue: [ ^ self ].

	view := elements anyOne view.
	realElements := elements collect: #realElement.
	view ifNil: [ ^ self ].
	
	realEdges := view edges select: [ :el | 
		(el isUsedInLayout and: [ realElements includes: el from ]) and: [ realElements includes: el to ] ].
	mockEdges := realEdges collect: [ :e | self newMockEdgeFor: e ].
	self edges: mockEdges.
	
]

{ #category : #hook }
RSOptimizedForceBasedLayout >> step [
	super step.
	mockElements do: #applyToRealElement
]
