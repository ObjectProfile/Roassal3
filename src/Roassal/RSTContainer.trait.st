"
My users can have edges and nodes useful to build graphs with roassal.
My users area:
- RSCanvas
- RSComposite
"
Trait {
	#name : 'RSTContainer',
	#instVars : [
		'shapeCollection'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'adding nodes edges' }
RSTContainer >> add: aShape [
	self
		assert: aShape isNotNil
		description: 'Nil cannot be added to this container'.
	aShape
		addedIn: self; "will choose the correct collection: lines or nodes"
		renderOn: self. "will update if necesary the shape"
	^ aShape
]

{ #category : 'adding nodes edges' }
RSTContainer >> addAll: aCollection [
	"Add a collection of shapes to the canvas. The argument is a collection of shapes."
	self assert: [ aCollection isCollection ] description: 'Need to provide a collection as argument'.
	self assert: [ aCollection allSatisfy: [ :e | e isKindOf: RSShape ] ] description: 'Need to provide a collection of RSShape'.

	"Add each shape"
	aCollection do: [ :aShape | self add: aShape ]
]

{ #category : 'adding' }
RSTContainer >> addAllShapes: aCollection [
	self assert: [ aCollection isCollection ] description: 'Need to provide a collection as argument'.
	self assert: [ aCollection allSatisfy: [ :e | e isKindOf: RSShape ] ] description: 'Need to provide a collection of RSShape'.
	aCollection do: [ :shape | self addShape: shape ]
]

{ #category : 'adding' }
RSTContainer >> addBasicShape: aShape [

	| aCollection |
	aCollection := self privateShapes.
	aCollection add: aShape.
	aShape entryIndex: aCollection size.
	shapeCollection add: aShape.
	aShape invalidate
]

{ #category : 'adding nodes edges' }
RSTContainer >> addEdge: aShape [
	self edges add: aShape.
	^ aShape
]

{ #category : 'adding nodes edges' }
RSTContainer >> addLine: aShape [
	self lines add: aShape.
	^ aShape
]

{ #category : 'adding nodes edges' }
RSTContainer >> addNode: aShape [
	self nodes add: aShape.
	^ aShape
]

{ #category : 'adding' }
RSTContainer >> addShape: aShape [
	aShape addedIn: self
]

{ #category : 'adding' }
RSTContainer >> addShape: aShape before: otherShape [
	| col index |
	aShape addedIn: self.
	col := aShape isFixed
		ifTrue: [ self fixedShapes ]
		ifFalse: [ self privateShapes ].
	col remove: aShape.
	col add: aShape before: otherShape.
	index := col indexOf: aShape.
	index to: col size do: [ :i | (col at: i) entryIndex: i ].
	aShape isFixed
		ifFalse: [ self shapeCollection updateEntry: aShape before: otherShape ]
]

{ #category : 'accessing' }
RSTContainer >> allChildren [
	| allChildren index |
	index := 1.
	allChildren := RSGroup withAll: self shapes.
	[ index <= allChildren size ] whileTrue: [
		allChildren addAll: ((allChildren at: index) children ifNil: [#()]).
		index := index + 1 ].
	^ allChildren
]

{ #category : 'accessing' }
RSTContainer >> children [
	^ self nodes
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapeFromModel: anObject [
	"Retreive a shape from a given model. Return nil if not found"
	| result |
	result := RSGroup new.
	self deepShapeFromModel: anObject result: result.
	result isEmpty ifTrue: [ ^ nil ].
	^ result first
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapeFromModel: anObject result: result [
	"Private method"
	| t |
	t := self shapeFromModel: anObject.
	t ifNotNil: [ result add: t ].
	self nodes do: [ :c | c deepShapeFromModel: anObject result: result ]
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapesFromModel: anObject [
	"Retreive a shape from a given model. Return nil if not found"
	| result |
	result := RSGroup new.
	self deepShapesFromModel: anObject result: result.
	^ result
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapesFromModel: anObject result: result [
	"Private method"
	self model = anObject ifTrue: [ result add: self ].
	self nodes do: [ :c | c deepShapesFromModel: anObject result: result ]
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapesFromModels: someObjects [
	"Retreive a shape from a given model. Return nil if not found"
	| result |
	result := RSGroup new.
	self deepShapesFromModels: someObjects result: result.
	^ result
]

{ #category : 'looking up shapes' }
RSTContainer >> deepShapesFromModels: someObjects result: result [
	"Private method"
	(someObjects includes: self model) ifTrue: [ result add: self ].
	self nodes do: [ :c | c deepShapesFromModel: someObjects result: result ]
]

{ #category : 'defaults' }
RSTContainer >> defaultShapeCollection [
	^ RTSequenceableCollection new
]

{ #category : 'accessing' }
RSTContainer >> edges [
	"Return all the lines contained in the canvas."
	^ self privateEdges
		ifNil: [ | res |
			self privateEdges: (res := RSGroup new).
			res ]
]

{ #category : 'accessing' }
RSTContainer >> fixedShapes [
	^ self explicitRequirement
]

{ #category : 'accessing' }
RSTContainer >> lines [
	"Return all the lines contained in the canvas."
	^ self privateEdges
		ifNil: [ | res |
			self privateEdges: (res := RSGroup new).
			res ]
]

{ #category : 'factory' }
RSTContainer >> newBezier [
	| s |
	s := RSBezier new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newBox [
	| s |
	s := RSBox new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newCircle [
	| s |
	s := RSCircle new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newEllipse [
	| s |
	s := RSEllipse new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newLabel [
	| s |
	s := RSLabel new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newLine [
	| s |
	s := RSLine new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newPolygon [
	| s |
	s := RSPolygon new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newPolyline [
	| s |
	s := RSPolyline new.
	self add: s.
	^ s
]

{ #category : 'factory' }
RSTContainer >> newSVGPath [
	| s |
	s := RSSVGPath new.
	self add: s.
	^ s
]

{ #category : 'accessing' }
RSTContainer >> nodes [
	"Return all the shapes except lines contained in the canvas."
	^ self privateNodes
		ifNil: [ | res |
			self privateNodes: (res := RSGroup new).
			res ]
]

{ #category : 'accessing' }
RSTContainer >> numberOfEdges [
	"OBSOLETE. USE #numberOfLines INSTEAD"
	"Return the number of edges contained in the container"
	^ self numberOfLines
]

{ #category : 'accessing' }
RSTContainer >> numberOfLines [
	"Return the number of edges contained in the container"
	^ self privateEdges
		ifNil: [ 0 ]
		ifNotNil: [ :aGroupOfEdges | aGroupOfEdges size ]
]

{ #category : 'accessing' }
RSTContainer >> numberOfNodes [
	"Return the number of nodes contained in the container"
	^ self privateNodes
		ifNil: [ 0 ]
		ifNotNil: [ :aGroupOfNodes | aGroupOfNodes size ]
]

{ #category : 'private' }
RSTContainer >> privateEdges [
	^ self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> privateEdges: aTSGroup [
	self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> privateNodes [
	^ self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> privateNodes: aTSGroup [
	self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> privateShapes [
	^ self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> privateShapes: aCollection [
	self explicitRequirement
]

{ #category : 'shapes - ordering' }
RSTContainer >> pushBack: arg1 [

	| tmp1 |
	tmp1 := arg1 isFixed
		        ifTrue: [ self fixedShapes ]
		        ifFalse: [ self privateShapes ].
	tmp1
		remove: arg1;
		addFirst: arg1.
	arg1 isFixed ifFalse: [ self shapeCollection pushBack: arg1 ].
	tmp1 doWithIndex: [ :arg2 :arg3 | arg2 entryIndex: arg3 ].
	arg1 invalidate
]

{ #category : 'actions' }
RSTContainer >> pushBackEdges [
	"Push back all the edges"
	self edges do: [ :e | e pushBack ]
]

{ #category : 'shapes - ordering' }
RSTContainer >> pushFront: arg1 [

	| tmp1 tmp2 |
	tmp1 := arg1 isFixed
		        ifTrue: [ self fixedShapes ]
		        ifFalse: [ self privateShapes ].
	tmp1
		remove: arg1;
		addLast: arg1.
	arg1 isFixed ifFalse: [ self shapeCollection pushFront: arg1 ].
	tmp2 := tmp1 size.
	arg1 entryIndex to: tmp2 do: [ :tmp3 |
	(tmp1 at: tmp3) entryIndex: tmp3 ].
	arg1
		entryIndex;
		invalidate
]

{ #category : 'removing' }
RSTContainer >> removeEdge: anEdge [
	self edges remove: anEdge ifAbsent: [  ]
]

{ #category : 'removing' }
RSTContainer >> removeNode: aNode [
	self nodes remove: aNode ifAbsent: [  ]
]

{ #category : 'removing' }
RSTContainer >> removeShape: aShape [
	^ self explicitRequirement
]

{ #category : 'accessing' }
RSTContainer >> shapeCollection [
	^ shapeCollection
]

{ #category : 'accessing' }
RSTContainer >> shapeCollection: anRSShapeCollection [
	| listOfShapes |
	shapeCollection := anRSShapeCollection.

	listOfShapes := self privateShapes.
	listOfShapes ifNil: [ ^ self ].
	shapeCollection bulkLoad: listOfShapes
]

{ #category : 'looking up shapes' }
RSTContainer >> shapeFromModel: anObject [
	"Retreive a shape from a given model. Return nil if not found"

	^ self nodes shapeFromModel: anObject
]

{ #category : 'accessing' }
RSTContainer >> shapes [
	^ self privateShapes
		ifNil: [ | res |
			self privateShapes: (res := RSGroup new).
			res ]
]

{ #category : 'looking up shapes' }
RSTContainer >> shapesFromModel: anObject [
	"Retreive a shape from a given model. Return nil if not found"

	^ self nodes shapesFromModel: anObject
]

{ #category : 'dirty areas' }
RSTContainer >> updateDirtyRectangleWith: aRectangle [
	self explicitRequirement
]

{ #category : 'private' }
RSTContainer >> updateInShapeCollection: aShape [
	"this is going to update the shape collection cache, spetially in RSRTree"
	self shapeCollection updateEntry: aShape
]

{ #category : 'shape - collection' }
RSTContainer >> useList [
	self shapeCollection: RTSequenceableCollection new
]

{ #category : 'shape - collection' }
RSTContainer >> useRTree [
	"use RTree for big data visualizations"
	self shapeCollection: RTreeCollection new
]

{ #category : 'accessing' }
RSTContainer >> withAllChildren [
	^ self allChildren
		add: self;
		yourself
]
