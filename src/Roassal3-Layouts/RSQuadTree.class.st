"
TODO
"
Class {
	#name : #RSQuadTree,
	#superclass : #RSObject,
	#instVars : [
		'charge',
		'x',
		'y',
		'leaf',
		'origin',
		'corner',
		'node',
		'cx',
		'cy',
		'northWest',
		'northEast',
		'southWest',
		'southEast'
	],
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #public }
RSQuadTree class >> withAll: aNodeCollection [

	^ self withAll: aNodeCollection origin: (aNodeCollection collect: [:e | e position x]) min @ (aNodeCollection collect: [:e | e position y]) min corner: (aNodeCollection collect: [:e | e position x]) max @ (aNodeCollection collect: [:e | e position y]) max
]

{ #category : #public }
RSQuadTree class >> withAll: aNodeCollection origin: aPoint corner: anotherPoint [

	| dx dy root |

	dx := anotherPoint x - aPoint x.
	dy := anotherPoint y - aPoint y.


	(dx closeTo: dy ) ifTrue: [ root := self new.
										root origin: aPoint;
											corner: anotherPoint.
										aNodeCollection do: [ :e | root add: e ].
										^ root ] .
	
	dx > dy ifTrue: [ ^ self withAll: aNodeCollection origin: aPoint corner: anotherPoint x @ (aPoint y + dx) ].
	dy > dx ifTrue: [ ^ self withAll: aNodeCollection origin: aPoint corner: (aPoint x + dy) @ anotherPoint y ] .
]

{ #category : #adding }
RSQuadTree >> add: aNode [
	| n |
	leaf
		ifTrue: [
			x isNil
				ifFalse: [
					(x - aNode position x) abs + (y - aNode position y) abs < 0.01
						ifTrue: [ self addChild: aNode ]
						ifFalse: [ n := node.
							x := nil.
							y := nil.
							node := nil.
							self
								addChild: aNode;
								addChild: n ] ]
				ifTrue: [
					x := aNode position x.
					y := aNode position y.
					node := aNode ] ]
		ifFalse: [ self addChild: aNode ]

]

{ #category : #adding }
RSQuadTree >> addChild: aNode [
	| sx sy new |
	sx := (origin x + corner x) / 2.
	sy := (origin y + corner y) / 2.
	leaf := false.

	aNode position x < sx
		ifTrue: [
			aNode position y < sy
				ifTrue: [
					northWest ifNil: [ 
						northWest := RSQuadTree new
							origin: origin;
							corner: sx @ sy;
							yourself ].
					northWest add: aNode ]
				ifFalse: [
					southWest ifNil: [ 
						southWest := RSQuadTree new
							origin: origin x @ sy;
							corner: sx @ corner y;
							yourself ].
					southWest add: aNode ] ]
		ifFalse: [
			aNode position y < sy
				ifTrue: [
					northEast ifNil: [
						northEast := RSQuadTree new
							origin: sx @ origin y;
							corner: corner x @ sy;
							yourself ].
					northEast add: aNode ]
				ifFalse: [
					southEast ifNil: [ 
						southEast := RSQuadTree new
							origin: sx @ sy;
							corner: corner;
							yourself ].
					southEast add: aNode ] ]

]

{ #category : #accessing }
RSQuadTree >> charge [
	^ charge
]

{ #category : #accessing }
RSQuadTree >> charge: anObject [
	charge := anObject
]

{ #category : #accessing }
RSQuadTree >> corner [
	^ corner
]

{ #category : #accessing }
RSQuadTree >> corner: anObject [
	corner := anObject
]

{ #category : #accessing }
RSQuadTree >> cx [
	^ cx
]

{ #category : #accessing }
RSQuadTree >> cx: aFloat [
	cx := aFloat
]

{ #category : #accessing }
RSQuadTree >> cy [
	^ cy
]

{ #category : #accessing }
RSQuadTree >> cy: aFloat [
	cy := aFloat
]

{ #category : #'initialize-release' }
RSQuadTree >> initialize [ 
	super initialize.
	
	leaf := true.

]

{ #category : #testing }
RSQuadTree >> isLeaf [
	^ leaf
]

{ #category : #accessing }
RSQuadTree >> node [
	^ node
]

{ #category : #accessing }
RSQuadTree >> notNilNodesDo: aBlockClosure [

  northWest ifNotNil: aBlockClosure.
  northEast ifNotNil: aBlockClosure.
  southWest ifNotNil: aBlockClosure.
  southEast ifNotNil: aBlockClosure.

]

{ #category : #accessing }
RSQuadTree >> origin [
	^ origin
]

{ #category : #accessing }
RSQuadTree >> origin: anObject [
	origin := anObject
]
