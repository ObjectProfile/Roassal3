"
TODO
"
Class {
	#name : #RSQuadTree,
	#superclass : #RSObject,
	#instVars : [
		'charge',
		'leaf',
		'origin',
		'corner',
		'cx',
		'cy',
		'soleChild',
		'northEastQuad',
		'northWestQuad',
		'southEastQuad',
		'southWestQuad'
	],
	#category : #'Roassal3-Layouts-Core'
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
	leaf
		ifTrue: [
			soleChild isNil
				ifTrue: [ soleChild := aNode ]
				ifFalse: [
					(soleChild position closeTo: aNode position)
						ifTrue: [ self addChild: aNode ]
						ifFalse: [
							| firstChild |
							firstChild := soleChild.
							soleChild := nil.
							self
								addChild: aNode;
								addChild: firstChild ] ] ]
		ifFalse: [ self addChild: aNode ]

]

{ #category : #adding }
RSQuadTree >> addChild: aNode [
	| sx sy |
	sx := (origin x + corner x) / 2.
	sy := (origin y + corner y) / 2.
	leaf := false.

	aNode position x < sx
		ifTrue: [
			aNode position y < sy
				ifTrue: [
					northWestQuad ifNil: [ 
						northWestQuad := RSQuadTree new
							origin: origin;
							corner: sx @ sy;
							yourself ].
					northWestQuad add: aNode ]
				ifFalse: [
					southWestQuad ifNil: [ 
						southWestQuad := RSQuadTree new
							origin: origin x @ sy;
							corner: sx @ corner y;
							yourself ].
					southWestQuad add: aNode ] ]
		ifFalse: [
			aNode position y < sy
				ifTrue: [
					northEastQuad ifNil: [
						northEastQuad := RSQuadTree new
							origin: sx @ origin y;
							corner: corner x @ sy;
							yourself ].
					northEastQuad add: aNode ]
				ifFalse: [
					southEastQuad ifNil: [ 
						southEastQuad := RSQuadTree new
							origin: sx @ sy;
							corner: corner;
							yourself ].
					southEastQuad add: aNode ] ]

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
RSQuadTree >> origin [
	^ origin
]

{ #category : #accessing }
RSQuadTree >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
RSQuadTree >> soleChild [
	^ soleChild
]

{ #category : #accessing }
RSQuadTree >> subQuadsDo: aBlockClosure [

  northWestQuad ifNotNil: aBlockClosure.
  northEastQuad ifNotNil: aBlockClosure.
  southWestQuad ifNotNil: aBlockClosure.
  southEastQuad ifNotNil: aBlockClosure.

]
