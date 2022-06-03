"
BTree node
"
Class {
	#name : #RSRNode,
	#superclass : #RSObject,
	#instVars : [
		'contents',
		'left',
		'right',
		'rectangle'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #'instance creation' }
RSRNode class >> new: anObject [
	^ self new
		contents: anObject;
		yourself
]

{ #category : #adding }
RSRNode >> add: anObject [ 
	self isLeaf ifTrue: [ 
		left := self class new: self contents.
		right := self class new: anObject.
		contents := nil.
	]ifFalse: [ | leastEnlargementChild |
		leastEnlargementChild := self leastEnlargementChild: anObject.
		leastEnlargementChild add: anObject.
		self flag: 'balance'.
	].
	rectangle := Rectangle merging: {left rectangle. right rectangle}.
]

{ #category : #accessing }
RSRNode >> children [
	^ {left. right} copyWithout: nil
]

{ #category : #enumerating }
RSRNode >> childrenDo: aBlock [
	left ifNotNil: aBlock.
	right ifNotNil: aBlock
]

{ #category : #accessing }
RSRNode >> contents [
	^ contents
]

{ #category : #accessing }
RSRNode >> contents: aRSShape [
	contents := aRSShape.
	rectangle := aRSShape encompassingRectangle.
]

{ #category : #enumerating }
RSRNode >> do: aBlock [
	self isLeaf
		ifTrue: [ aBlock value: self contents ]
		ifFalse: [ 
			self childrenDo: [ :child | child do: aBlock ].
			 ]
	
]

{ #category : #accessing }
RSRNode >> height [
	^ self isLeaf
		ifTrue: [ 1 ]
		ifFalse: [ (left height max: right height) + 1 ]
]

{ #category : #inspector }
RSRNode >> inspectionTree: aBuilder [
    <inspectorPresentationOrder: 1 title: 'Tree Structure'>

    ^ aBuilder newTree
        roots: { self };
        children: [ :each | each children ];
        expandRoots;
        yourself
]

{ #category : #testing }
RSRNode >> isBalanced [
	^ self isLeaf
		ifTrue: [ true ]
		ifFalse: [ (left height - right height) abs <= 1  ]
]

{ #category : #testing }
RSRNode >> isInvalid [
	^ self isLeaf and: [ self contents isNil ]
]

{ #category : #testing }
RSRNode >> isLeaf [
	^ right isNil and: [ left isNil ]
]

{ #category : #adding }
RSRNode >> leastEnlargementChild: anObject [
	| minRectangleEnlargement rect leftRect rightRect leftDiff rightDiff |
	minRectangleEnlargement := nil.
	rect := anObject encompassingRectangle.
	leftRect := Rectangle merging: {left rectangle. rect }.
	rightRect := Rectangle merging: {right rectangle. rect }.
	leftDiff := leftRect area - left rectangle area.
	rightDiff := rightRect area - right rectangle area.
	^ rightDiff <  leftDiff 
		ifTrue: [ right ]
		ifFalse: [ left ].	
]

{ #category : #accessing }
RSRNode >> left [
	^ left
]

{ #category : #'finding/searching' }
RSRNode >> nodesIntersetcsRectangle: aRectangle list: aCollection [ 
	(self rectangle intersects: aRectangle) ifFalse: [ ^ self ].
	self isLeaf ifTrue: [ 
		(self contents encompassingRectangle intersects: aRectangle)
			ifTrue: [ aCollection add: self contents ] ]
	ifFalse: [ 
		self childrenDo: [ :child | 
			child nodesIntersetcsRectangle: aRectangle list: aCollection
			 ] ]
]

{ #category : #'finding/searching' }
RSRNode >> nodesWithPoint: aPoint list: aCollection [ 
	(self rectangle containsPoint: aPoint)
		ifFalse: [ ^ self ].
	self isLeaf ifTrue:[
		(self contents includesPoint: aPoint) ifTrue: [
			aCollection add: self contents.
			].
	] ifFalse: [ 
		self childrenDo: [ :child | child nodesWithPoint: aPoint list: aCollection ]
	]
]

{ #category : #accessing }
RSRNode >> rectangle [
	^ rectangle
]

{ #category : #removing }
RSRNode >> remove: anObject [
	| removedObject |
	removedObject := nil.
	self isLeaf ifTrue: [ 
		self contents = anObject ifTrue: [ 
			removedObject := contents.
			contents := nil.
			rectangle := nil.
			 ]
	] ifFalse: [ 
		self childrenDo: [ :child |
			removedObject := child remove: anObject.
			removedObject ifNotNil: [ 
				child isInvalid ifTrue: [ 
					left = child ifTrue: [ left := nil ].
					right = child ifTrue: [ right := nil ].
					 ].
				^ removedObject
			 ].
		]
	].
	
	^ removedObject
]

{ #category : #accessing }
RSRNode >> right [
	^ right
]
