"
AVL to check rotations
"
Class {
	#name : #RSAVL,
	#superclass : #Collection,
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSAVL >> add: newObject [ 
	root isNilNode
		ifTrue: [ root := RSAVLNode with: newObject ]
		ifFalse: [ | path |
			path := OrderedCollection with: nil -> root.
			root add: newObject path: path.
			self checkPath: path  ].
	^ newObject
]

{ #category : #accessing }
RSAVL >> allChildren [
	| list |
	list := OrderedCollection new.
	self root withAllChildren: list.
	^ list
]

{ #category : #private }
RSAVL >> balance: index path: aCollection [ 
	| x y z a b c |
	z := aCollection at: index.
	y := aCollection at: index + 1.
	x := aCollection at: index + 2.
	c := z value.
	b := y value.
	a := x value.
	(y key and: [ x key ]) ifTrue: [ 
		^ self rrrotationZ: c y: b x: a ].
	(y key not and: [ x key not ]) ifTrue: [ 
		^ self llrotationZ: c y: b x: a ].
	(y key not and: [ x key ]) ifTrue: [ 
		^ self lrrotationZ: c y: b x: a ].
	"(y key and: [ x key not ])"
	^ self rlrotationZ: c y: b x: a.
	"self notYetImplemented."
]

{ #category : #private }
RSAVL >> checkPath: aCollection [ 
	aCollection size < 3 ifTrue: [ ^ self ].
	(1 to: aCollection size - 2) reverseDo: [ :index |
		| assoc |
		assoc := aCollection at: index.
		assoc value isBalanced ifFalse: [ ^ self balance: index path: aCollection ] ]
]

{ #category : #enumerating }
RSAVL >> do: aBlock [ 
	root do: aBlock
]

{ #category : #public }
RSAVL >> height [
	^ root height
]

{ #category : #testing }
RSAVL >> includes: anObject [
	anObject ifNil: [ ^ nil ].
	^ (self search: anObject) notNil
]

{ #category : #initialization }
RSAVL >> initialize [
	super initialize.
	root := RSAVLNilNode new.
]

{ #category : #testing }
RSAVL >> isBalanced [
	^ root isBalanced
]

{ #category : #private }
RSAVL >> llrotationZ: z y: y x: x [ 
	| a3 a4 new |
	a3 := y right.
	a4 := z right.
	
	new := RSAVLNode with: z contents.
	new left: a3; right: a4.
	z left: x; contents: y contents; right: new.
	
]

{ #category : #private }
RSAVL >> lrrotationZ: z y: y x: x [ 
	| a1 a2 a3 new |
	a1 := y left.
	a2 := x left.
	a3 := x right.
	new := RSAVLNode with: y contents.
	new left: a1; right: a2.
	y contents: x contents; left: new; right: a3.
	
	self llrotationZ: z y: y x: new
]

{ #category : #removing }
RSAVL >> remove: oldObject ifAbsent: anExceptionBlock [ 
	^ root remove: oldObject ifAbsent: anExceptionBlock
]

{ #category : #private }
RSAVL >> rlrotationZ: z y: y x: x [ 
	| a1 a2 a3 a4 new |
	a1 := z left.
	a2 := x left.
	a3 := x right.
	a4 := y right.
	new := RSAVLNode with: y contents.
	new left: a3; right: a4.
	y contents: x contents; left: a2; right: new.
	self rrrotationZ: z y: y x: new
]

{ #category : #accessing }
RSAVL >> root [
	^ root
]

{ #category : #private }
RSAVL >> rrrotationZ: z y: y x: x [
	"right right rotation"
	| a1 a2 new |
	a1 := z left.
	a2 := y left.
	
	new := RSAVLNode with: z contents.
	new left: a1; right: a2.
	z left: new; right: x; contents: y contents
	
]

{ #category : #search }
RSAVL >> search: anInteger [ 
	^ root search: anInteger
]
