"
Real node for AVL tree
"
Class {
	#name : #RSAVLNode,
	#superclass : #RSAVLAbstractNode,
	#instVars : [
		'left',
		'contents',
		'right'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #'instance creation' }
RSAVLNode class >> with: anInteger [ 
	^ self new
		contents: anInteger;
		yourself
]

{ #category : #adding }
RSAVLNode >> add: anInteger path: list [
	anInteger < contents  ifTrue: [ 
		left 
			ifNil: [ 
				left := self class with: anInteger.
				list add: false -> left ]
			ifNotNil: [ 
				list add: false -> left.
				left add: anInteger path: list ]
	] ifFalse: [ 
		right 
			ifNil: [ 
				right := self class with: anInteger.
				list add: true -> right ]
			ifNotNil: [ 
				list add: true -> right.
				right add: anInteger path: list ] ]
	
]

{ #category : #accessing }
RSAVLNode >> children [
	^ { left. right } reject: #isNil
]

{ #category : #enumerating }
RSAVLNode >> childrenDo: aFullBlockClosure [ 
	left ifNotNil: aFullBlockClosure.
	right ifNotNil: aFullBlockClosure.
]

{ #category : #accessing }
RSAVLNode >> contents [
	^ contents
]

{ #category : #accessing }
RSAVLNode >> contents: anInteger [ 
	contents := anInteger
]

{ #category : #enumerating }
RSAVLNode >> do: aFullBlockClosure [ 
	left ifNotNil: [ left do: aFullBlockClosure ].
	aFullBlockClosure value: self contents.
	right ifNotNil: [ right do: aFullBlockClosure ].
]

{ #category : #accessing }
RSAVLNode >> height [
	| leftHeight rightHeight |
	leftHeight := left ifNil: [ 0 ] ifNotNil: [ left height ].
	rightHeight := right ifNil: [ 0 ] ifNotNil: [ right height ].
	^ (leftHeight max: rightHeight) + 1
	
]

{ #category : #testing }
RSAVLNode >> isBalanced [
	| leftHeight rightHeight |
	leftHeight := left ifNil: [ 0 ] ifNotNil: [ left height ].
	rightHeight := right ifNil: [ 0 ] ifNotNil: [ right height ].
	
	^ (leftHeight - rightHeight) abs <= 1
]

{ #category : #testing }
RSAVLNode >> isLeaf [
	^ left isNil and: [ right isNil ]
]

{ #category : #accessing }
RSAVLNode >> left [
	^ left
]

{ #category : #accessing }
RSAVLNode >> left: aNode [ 
	left := aNode
]

{ #category : #printing }
RSAVLNode >> printOn: stream [
	contents printOn: stream
]

{ #category : #accessing }
RSAVLNode >> right [
	^ right
]

{ #category : #accessing }
RSAVLNode >> right: anObject [ 
	right := anObject
]

{ #category : #search }
RSAVLNode >> search: anInteger [ 
	^ contents = anInteger ifTrue: [
		contents
	] ifFalse: [
		| node |
		node := anInteger < contents
			ifTrue: [ left ]
			ifFalse: [ right ].
		node ifNil: [ nil ] ifNotNil: [ node search: anInteger ]
	]
]

{ #category : #accessing }
RSAVLNode >> withAllChildren: aCollection [ 
	aCollection add: self.
	self childrenDo: [ :child | child withAllChildren: aCollection ]
]
