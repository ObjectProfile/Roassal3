"
used to navigate between big models, quadtree is used
"
Class {
	#name : #RSQuadTree,
	#superclass : #RSObject,
	#instVars : [
		'rectangle',
		'soleChild',
		'northWestQuad',
		'northEastQuad',
		'southWestQuad',
		'southEastQuad',
		'isLeaf'
	],
	#category : #'Roassal-Layouts-Util'
}

{ #category : #public }
RSQuadTree class >> position: aShape [
	^ aShape position
]

{ #category : #'instance creation' }
RSQuadTree class >> withAll: aRSGroup [
	^ self
		withAll: aRSGroup
		rectangle: (Rectangle encompassing: (aRSGroup collect: [:each | self position: each ]))
]

{ #category : #'instance creation' }
RSQuadTree class >> withAll: aRSGroup rectangle: rectangle [
	| root extent |
	extent := rectangle extent.

	(extent x closeTo: extent y) ifTrue: [
		root := self new.
		root rectangle: rectangle.
		aRSGroup do: [ :shape | root add: shape ].
		^ root ].

	^ extent x > extent y
		ifTrue: [
			self
				withAll: aRSGroup
				rectangle: (rectangle origin
					corner: rectangle corner x @ (extent x + rectangle origin y)) ]
		ifFalse: [
			self
				withAll: aRSGroup
				rectangle: (rectangle origin
					corner: (extent y + rectangle origin x) @ rectangle corner y) ]
]

{ #category : #adding }
RSQuadTree >> add: aShape [
	isLeaf ifTrue: [
		soleChild
			ifNil: [ soleChild := aShape ]
			ifNotNil: [
				((self position: soleChild) closeTo: (self position: aShape))
					ifTrue: [ self addChild: aShape ]
					ifFalse: [
						| firstChild |
						firstChild := soleChild.
						soleChild := nil.
						self
							addChild: aShape;
							addChild: firstChild ] ] ]
	ifFalse: [ self addChild: aShape ]
]

{ #category : #adding }
RSQuadTree >> addChild: aShape [
	| center origin corner position |
	isLeaf := false.
	center := rectangle floatCenter.
	origin := rectangle origin.
	corner := rectangle corner.
	position := self position: aShape.

	position x < center x
		ifTrue: [
			position y < center y
				ifTrue: [
					northWestQuad ifNil: [
						northWestQuad := self class new
							rectangle: (origin corner: center);
							yourself ].
					northWestQuad add: aShape ]
				ifFalse: [
					southWestQuad ifNil: [
						southWestQuad := self class new
							rectangle: ((origin x @ center y ) corner: (center x @ corner y));
							yourself ].
					southWestQuad add: aShape ] ]
		ifFalse: [
			position y < center y
				ifTrue: [
					northEastQuad ifNil: [
						northEastQuad := self class new
							rectangle: ((center x @ origin y) corner: (corner x @ center y));
							yourself ].
					northEastQuad add: aShape ]
				ifFalse: [
					southEastQuad ifNil: [
						southEastQuad := self class new
							rectangle: (center corner: corner);
							yourself ].
					southEastQuad add: aShape ] ]
]

{ #category : #initialization }
RSQuadTree >> initialize [
	super initialize.
	isLeaf := true
]

{ #category : #testing }
RSQuadTree >> isLeaf [
	^ isLeaf
]

{ #category : #accessing }
RSQuadTree >> position: aShape [
	^ self class position: aShape
]

{ #category : #accessing }
RSQuadTree >> rectangle [
	^ rectangle
]

{ #category : #accessing }
RSQuadTree >> rectangle: aRectangle [
	rectangle := aRectangle
]

{ #category : #accessing }
RSQuadTree >> soleChild [
	^ soleChild
]

{ #category : #enumeration }
RSQuadTree >> subQuadsDo: aBlockClosure [
	northWestQuad ifNotNil: aBlockClosure.
	northEastQuad ifNotNil: aBlockClosure.
	southWestQuad ifNotNil: aBlockClosure.
	southEastQuad ifNotNil: aBlockClosure
]

{ #category : #private }
RSQuadTree >> visibleShapeContains: aPoint list: listResult [
	(self rectangle containsPoint: aPoint) ifFalse: [ ^ self ].
	self isLeaf ifTrue: [
		(self soleChild encompassingRectangle containsPoint: aPoint)
			ifTrue: [ listResult add: self soleChild ]
	] ifFalse: [
		self subQuadsDo: [ :aQuad |
			aQuad visibleShapeContains: aPoint list: listResult ]
	]
]

{ #category : #'finding/searching' }
RSQuadTree >> visibleShapeContainsPoint: aPoint [

	| listResult |
	listResult := OrderedCollection new.
	self visibleShapeContains: aPoint list: listResult.
	^ listResult size = 1
		ifTrue: [ listResult first ]
		ifFalse: [ nil ]
]

{ #category : #'finding/searching' }
RSQuadTree >> visibleShapesFrom: aRectangle [

	| listResult |
	listResult := OrderedCollection new.
	self visibleShapesFrom: aRectangle list: listResult.
	^ listResult
]

{ #category : #private }
RSQuadTree >> visibleShapesFrom: aRectangle list: listResult [

	(self rectangle intersects: aRectangle) ifFalse: [ ^ self ].
	self isLeaf
		ifTrue: [
			(self soleChild encompassingRectangle intersects: aRectangle)
				ifTrue: [ listResult add: self soleChild ] ]
		ifFalse: [
			self subQuadsDo: [ :aQuad |
				aQuad visibleShapesFrom: aRectangle list: listResult ] ]
]
