"
TODO
"
Class {
	#name : #RSQuadTreeF,
	#superclass : #RSObject,
	#instVars : [
		'charge',
		'leaf',
		'soleChild',
		'northEastQuad',
		'northWestQuad',
		'southEastQuad',
		'southWestQuad',
		'centerOfCharge',
		'rectangle'
	],
	#category : #'Roassal3-Layouts-Util'
}

{ #category : #public }
RSQuadTreeF class >> withAll: aNodeCollection [
	^ self
		withAll: aNodeCollection
		rectangle: (Rectangle encompassing: (aNodeCollection collect: #position))
]

{ #category : #public }
RSQuadTreeF class >> withAll: aNodeCollection rectangle: rectangle [
	
	| root extent |
	extent := rectangle extent.

	(extent x closeTo: extent y) ifTrue: [ 
		root := self new.
		root rectangle: rectangle.
		aNodeCollection do: [ :e | root add: e ].
		^ root ].
	
	^ extent x > extent y
		ifTrue: [ 
			self 
				withAll: aNodeCollection
				rectangle: (rectangle origin corner: rectangle corner x @ (extent x + rectangle origin y)) ]
		ifFalse: [
			self 
				withAll: aNodeCollection
				rectangle: (rectangle origin corner: (extent y + rectangle origin x) @ rectangle corner y) ]


]

{ #category : #adding }
RSQuadTreeF >> add: aNode [
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
RSQuadTreeF >> addChild: aNode [
	| s origin corner |
	leaf := false.
	s := rectangle floatCenter.
	origin := rectangle origin.
	corner := rectangle corner.

	aNode position x < s x
		ifTrue: [
			aNode position y < s y
				ifTrue: [
					northWestQuad ifNil: [ 
						northWestQuad := RSQuadTreeF new
							rectangle: (origin corner: s);
							yourself ].
					northWestQuad add: aNode ]
				ifFalse: [
					southWestQuad ifNil: [ 
						southWestQuad := RSQuadTreeF new
							rectangle: ((origin x @ s y ) corner: (s x @ corner y));
							yourself ].
					southWestQuad add: aNode ] ]
		ifFalse: [
			aNode position y < s y
				ifTrue: [
					northEastQuad ifNil: [
						northEastQuad := RSQuadTreeF new
							rectangle: ((s x @ origin y) corner: (corner x @ s y));
							yourself ].
					northEastQuad add: aNode ]
				ifFalse: [
					southEastQuad ifNil: [ 
						southEastQuad := RSQuadTreeF new
							rectangle: (s corner: corner);
							yourself ].
					southEastQuad add: aNode ] ]

]

{ #category : #accessing }
RSQuadTreeF >> centerOfCharge [
	^ centerOfCharge
]

{ #category : #accessing }
RSQuadTreeF >> centerOfCharge: aPoint [
	centerOfCharge := aPoint
]

{ #category : #accessing }
RSQuadTreeF >> charge [
	^ charge
]

{ #category : #accessing }
RSQuadTreeF >> charge: anObject [
	charge := anObject
]

{ #category : #'initialize-release' }
RSQuadTreeF >> initialize [ 
	super initialize.
	
	leaf := true.

]

{ #category : #testing }
RSQuadTreeF >> isLeaf [
	^ leaf
]

{ #category : #accessing }
RSQuadTreeF >> rectangle [
	^ rectangle
]

{ #category : #accessing }
RSQuadTreeF >> rectangle: aRectangle [ 
	rectangle := aRectangle
]

{ #category : #accessing }
RSQuadTreeF >> soleChild [
	^ soleChild
]

{ #category : #accessing }
RSQuadTreeF >> subQuadsDo: aBlockClosure [
  northWestQuad ifNotNil: aBlockClosure.
  northEastQuad ifNotNil: aBlockClosure.
  southWestQuad ifNotNil: aBlockClosure.
  southEastQuad ifNotNil: aBlockClosure.

]
