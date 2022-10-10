"
An R-tree for roassal3
"
Class {
	#name : #RSRTreeShapeCollection,
	#superclass : #RSShapeCollection,
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSRTreeShapeCollection >> add: newObject [
	root := root addChild: newObject.
	^ newObject
]

{ #category : #enumerating }
RSRTreeShapeCollection >> do: aBlock [ 
	root do: aBlock
]

{ #category : #accessing }
RSRTreeShapeCollection >> height [
	^ root height
	
]

{ #category : #initialization }
RSRTreeShapeCollection >> initialize [
	super initialize.
	root := RSRNilNode new.
]

{ #category : #testing }
RSRTreeShapeCollection >> isBalanced [
	^ root isBalanced
]

{ #category : #testing }
RSRTreeShapeCollection >> isEmpty [
	^ root isEmpty
]

{ #category : #testing }
RSRTreeShapeCollection >> isTotalBalanced [
	^ root isTotalBalanced
]

{ #category : #accessing }
RSRTreeShapeCollection >> rectangle [
	^ root rectangle
]

{ #category : #removing }
RSRTreeShapeCollection >> remove: oldObject ifAbsent: anExceptionBlock [ 
	
	^ root isNilNode
		ifTrue: anExceptionBlock
		ifFalse: [ | removedObject |
			removedObject := root remove: oldObject.
			removedObject 
				ifNil: anExceptionBlock
				ifNotNil: [
					root isInvalid
						ifTrue: [ root := RSRNilNode new ]
					]
			].
]

{ #category : #accessing }
RSRTreeShapeCollection >> root [
	^ root
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtPoint: aPoint [ 
	| res |
	res := OrderedCollection new.
	root nodesWithPoint: aPoint list: res.
	^ res
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtRectangle: aRectangle [
	| res |
	res := OrderedCollection new.
	root nodesIntersetcsRectangle: aRectangle list: res.
	^ res
]
