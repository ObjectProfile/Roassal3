"
TODO
"
Class {
	#name : #TSQuadTreeF,
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
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #public }
TSQuadTreeF class >> withAll: aNodeCollection [
	^ self
		withAll: aNodeCollection
		rectangle: (Rectangle encompassing: (aNodeCollection collect: #position))
]

{ #category : #public }
TSQuadTreeF class >> withAll: aNodeCollection rectangle: rectangle [
	
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
TSQuadTreeF >> add: aNode [
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
TSQuadTreeF >> addChild: aNode [
	| s origin corner |
	leaf := false.
	s := rectangle rsCenter.
	origin := rectangle origin.
	corner := rectangle corner.

	aNode position x < s x
		ifTrue: [
			aNode position y < s y
				ifTrue: [
					northWestQuad ifNil: [ 
						northWestQuad := TSQuadTreeF new
							rectangle: (origin corner: s);
							yourself ].
					northWestQuad add: aNode ]
				ifFalse: [
					southWestQuad ifNil: [ 
						southWestQuad := TSQuadTreeF new
							rectangle: ((origin x @ s y ) corner: (s x @ corner y));
							yourself ].
					southWestQuad add: aNode ] ]
		ifFalse: [
			aNode position y < s y
				ifTrue: [
					northEastQuad ifNil: [
						northEastQuad := TSQuadTreeF new
							rectangle: ((s x @ origin y) corner: (corner x @ s y));
							yourself ].
					northEastQuad add: aNode ]
				ifFalse: [
					southEastQuad ifNil: [ 
						southEastQuad := TSQuadTreeF new
							rectangle: (s corner: corner);
							yourself ].
					southEastQuad add: aNode ] ]

]

{ #category : #accessing }
TSQuadTreeF >> centerOfCharge [
	^ centerOfCharge
]

{ #category : #accessing }
TSQuadTreeF >> centerOfCharge: aPoint [
	centerOfCharge := aPoint
]

{ #category : #accessing }
TSQuadTreeF >> charge [
	^ charge
]

{ #category : #accessing }
TSQuadTreeF >> charge: anObject [
	charge := anObject
]

{ #category : #'initialize-release' }
TSQuadTreeF >> initialize [ 
	super initialize.
	
	leaf := true.

]

{ #category : #testing }
TSQuadTreeF >> isLeaf [
	^ leaf
]

{ #category : #accessing }
TSQuadTreeF >> rectangle [
	^ rectangle
]

{ #category : #accessing }
TSQuadTreeF >> rectangle: aRectangle [ 
	rectangle := aRectangle
]

{ #category : #accessing }
TSQuadTreeF >> soleChild [
	^ soleChild
]

{ #category : #accessing }
TSQuadTreeF >> subQuadsDo: aBlockClosure [

  northWestQuad ifNotNil: aBlockClosure.
  northEastQuad ifNotNil: aBlockClosure.
  southWestQuad ifNotNil: aBlockClosure.
  southEastQuad ifNotNil: aBlockClosure.

]
