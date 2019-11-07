"
RSEdgeBuilder offers an API to easily build edges.

Here is an example:
```
v := RSView new.

classes := Collection withAllSubclasses.
boxes := RSShapeBuilder box
				width: [ :cls | cls instVarNames size * 5 max: 5 ];
				height: [ :cls | cls numberOfMethods max: 5 ];
				elementsOn: classes.
boxes @ RSDraggable.
v addAll: boxes.

RSEdgeBuilder orthoVertical
	view: v;
	attachPoint: RSVerticalAttachPoint new;
	elements: boxes;
	connectFrom: #superclass.

RSTreeLayout on: v elements.
v @ RSControlsView.
v open
```
"
Class {
	#name : #TSEdgeBuilder,
	#superclass : #RSObject,
	#instVars : [
		'shape',
		'allowRepetition',
		'shouldMoveBehind',
		'createdEdges',
		'beDirectional',
		'attachPoint',
		'controlPoints',
		'fromShapes',
		'toShapes',
		'canvas',
		'canvasHasBeenManuallySet'
	],
	#category : #'Roassal3-Shapes-Graph'
}

{ #category : #'instance creation' }
TSEdgeBuilder class >> arrowedLine [
	| marker shape |
	marker := TSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		paint: nil;
		withBorder.
	shape := TSLine new.
	shape markerEnd: marker.
	^ self new: shape
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> horizontalLine: aShape [
	^ (self new: aShape) controlPoints: [:from :to | 
		| mid |
		mid := (from + to)/2.
		Array 
			with: from
			with: mid x @ from y
			with: mid x @ to y
			with: to ];
		yourself.
	
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> line [
	^ self new: TSLine new
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> new: aTSShape [
	 ^ self new 
		shape: aTSShape;
		yourself
		
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> orthoHorizontal [
	^ self horizontalLine: TSPolyline new.
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> orthoVertical [
	^ self verticalLine: TSPolyline new.
]

{ #category : #'instance creation' }
TSEdgeBuilder class >> verticalLine: aShape [
	^ (self new: aShape) controlPoints: [ :from :to | 
		| mid |
		mid := (from + to)/2.
		Array
			with: from
			with: from x @ mid y
			with: to x @ mid y
			with: to ];
		yourself.
	
]

{ #category : #'public - shape' }
TSEdgeBuilder >> addInteraction: anInteraction [
	self shape addInteraction: anInteraction
]

{ #category : #'public repetition' }
TSEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #'public - attach point' }
TSEdgeBuilder >> attachPoint [
	^ attachPoint
]

{ #category : #'public - attach point' }
TSEdgeBuilder >> attachPoint: anAttachPoint [
	attachPoint := anAttachPoint
]

{ #category : #'public - configuration' }
TSEdgeBuilder >> beDirectional [
	"When edges are created, this allow for having edges going from A to B, and from B to A"
	beDirectional := true
]

{ #category : #'public - shape' }
TSEdgeBuilder >> border [
	^ self shape border
]

{ #category : #'public - shape' }
TSEdgeBuilder >> border: aBorder [
	self shape border: aBorder
]

{ #category : #'public - shape' }
TSEdgeBuilder >> borderColor: aColor [
	self shape borderColor: aColor
]

{ #category : #accessing }
TSEdgeBuilder >> canvas [
	^ canvas
]

{ #category : #accessing }
TSEdgeBuilder >> canvas: aCanvas [
	canvasHasBeenManuallySet := true.
	canvas := aCanvas
]

{ #category : #accessing }
TSEdgeBuilder >> canvasNodes [
	canvas ifNil: [ ^ #() ].
	^ canvas nodes
]

{ #category : #'public - shape' }
TSEdgeBuilder >> color: aColor [
	self shape color: aColor
]

{ #category : #public }
TSEdgeBuilder >> connectFrom: aBlockOrASymbol [
	^ self connectFrom: aBlockOrASymbol to: [ :each | each ]
]

{ #category : #public }
TSEdgeBuilder >> connectFrom: aFromBlock to: aBlockOrASymbol [
	| toElement fromElement |
	self resetCreatedEdges.
	self fromShapes copy do: [ :e | 
			fromElement := self fromShapes shapeFromModel: (aFromBlock rsValue: e model).
			toElement := self toShapes shapeFromModel: (aBlockOrASymbol rsValue: e model).
			toElement ifNotNil: [ self createEdgeIfNecessaryFrom: fromElement to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
TSEdgeBuilder >> connectFrom: aFromBlock toAll: aBlockOrASymbol [

	| fromElement tes |
	self resetCreatedEdges.
	self fromShapes copy do: [ :e | 
		fromElement := self fromShapes shapeFromModel: (aFromBlock rsValue: e model).
		tes := self toShapes shapesFromModels: (aBlockOrASymbol rsValue: e model).
		tes ifNotNil: [ 
			tes do: [ :toE | 
				self createEdgeIfNecessaryFrom: fromElement to: toE ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges 
]

{ #category : #public }
TSEdgeBuilder >> connectFromAll: aFromBlockOrSymbol [
	^ self connectFromAll: aFromBlockOrSymbol to: [ :each | each ]

]

{ #category : #public }
TSEdgeBuilder >> connectFromAll: aFromBlockOrSymbol to: aBlockOrASymbol [

	| toElement tfromElements |
	self resetCreatedEdges.
	self fromShapes copy do: [ :e | 
		tfromElements := self fromShapes shapesFromModels: (aFromBlockOrSymbol rsValue: e model). 
		toElement := self toShapes shapeFromModel: (aBlockOrASymbol rsValue: e model).
		tfromElements ifNotNil: [ 
			tfromElements do: [ :fromElement | 
				self createEdgeIfNecessaryFrom: fromElement to: toElement ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
TSEdgeBuilder >> connectTo: aBlockOrASymbol [
	^ self connectFrom: [ :each | each ] to: aBlockOrASymbol
]

{ #category : #public }
TSEdgeBuilder >> connectToAll: aBlockOrASymbol [
	"Should this method use connectFrom:ToAll: ?????"
	| tmptoElements |
	self resetCreatedEdges.
	self fromShapes copy do: [ :e | 
		tmptoElements := self toShapes shapesFromModels: (aBlockOrASymbol rsValue: e model).
		tmptoElements ifNotNil: [ 
			tmptoElements do: [ :toE | 
				self createEdgeIfNecessaryFrom: e to: toE ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #accessing }
TSEdgeBuilder >> controlPoints [
	^ controlPoints
]

{ #category : #accessing }
TSEdgeBuilder >> controlPoints: aBlock [
	controlPoints := aBlock
]

{ #category : #'private - utility' }
TSEdgeBuilder >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	"This is a private method. Create, if necessary, an edge between two elements"
	(self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ createdEdges add: (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'private - utility' }
TSEdgeBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| edge |
	edge := self shape copy
		model: source model -> target model;
		attachPoint: self attachPoint;
		from: source;
		to: target;
		yourself.
	canvas ifNotNil: [ canvas add: edge ].
	controlPoints ifNotNil: [ edge controlPointsBlock: controlPoints ].
	^ edge
]

{ #category : #accessing }
TSEdgeBuilder >> fromObjects [
	"Return the list of objects considered as targets for the edges"
	^ self fromShapes collect: #model
]

{ #category : #accessing }
TSEdgeBuilder >> fromObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self fromShapes: (canvas shapesFromModels: someObjectsOrABlock) ]
		ifFalse: [ self fromShapes: (canvas nodes select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
]

{ #category : #accessing }
TSEdgeBuilder >> fromShapes [
	fromShapes ifNil: [ ^ self canvasNodes ].
	^ fromShapes
]

{ #category : #accessing }
TSEdgeBuilder >> fromShapes: someShapes [
	fromShapes := someShapes asGroup
]

{ #category : #initialization }
TSEdgeBuilder >> initialize [
	super initialize.
	self noRepetition.
	shouldMoveBehind := false.
	
	"The view has to be explicitly set by the end-user"
	canvasHasBeenManuallySet := false.
	"We could have edges from A to B, and from B to A"
	self beDirectional.
	self attachPoint: RSCenteredAttachPoint new.
]

{ #category : #testing }
TSEdgeBuilder >> isBidirectional [
	"Return true or false, indicating whether the edge builder is bidirectional or not (i.e., if 
	edges from A to B, __and__ B to A can be created"
	^ beDirectional 
]

{ #category : #'public - shape' }
TSEdgeBuilder >> markerEnd: aMarker [
	self shape markerEnd: aMarker
]

{ #category : #'public - shape' }
TSEdgeBuilder >> markerStart: aMarker [
	self shape markerStart: aMarker
]

{ #category : #accessing }
TSEdgeBuilder >> moveBehind [
	"Set the builder as such that edge that are built and added in the view _behind_ the extremities of each edges"
	shouldMoveBehind := true
]

{ #category : #'private - utility' }
TSEdgeBuilder >> moveBehindIfNecessary: someEdges [
	shouldMoveBehind ifFalse: [ ^ self ].
	someEdges pushBack
]

{ #category : #'public - configuration' }
TSEdgeBuilder >> noBidirectional [
	"When edges are created, this does not allow for having edges going from A to B, and from B to A. Only A to B, __OR__, B to A is created"
	beDirectional := false
]

{ #category : #'public - configuration' }
TSEdgeBuilder >> noRepetition [
	"
	Avoid having more than one edge between two elements

	b := RTMondrian new.
	b nodes: (1 to: 3).
	b shape line
		color: Color red trans;
		withVerticallAttachPoint.
	b edges noRepetition; useAssociations: { 1 -> 2 . 2 -> 3 . 1 -> 2}.
	b layout grid.
	b build.
	b view numberOfEdges
	"
	allowRepetition := false
]

{ #category : #accessing }
TSEdgeBuilder >> object: anObject [
	^ self objects: (Array with: anObject)
]

{ #category : #accessing }
TSEdgeBuilder >> objects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	self toObjects: someObjectsOrABlock.
	self fromObjects: someObjectsOrABlock.
]

{ #category : #'private - utility' }
TSEdgeBuilder >> resetCreatedEdges [
	createdEdges := RSGroup new
]

{ #category : #'public - shape' }
TSEdgeBuilder >> shape [
	^ shape
]

{ #category : #'public - shape' }
TSEdgeBuilder >> shape: aTSShape [
	shape := aTSShape
]

{ #category : #accessing }
TSEdgeBuilder >> shapes: someShapes [
	self toShapes: someShapes.
	self fromShapes: someShapes
]

{ #category : #'public repetition' }
TSEdgeBuilder >> shouldAllowRepetition [
	^ allowRepetition
]

{ #category : #testing }
TSEdgeBuilder >> shouldCreateEdgeFrom: fromElement to: toElement [
	"Return true if an edge has to be created"
	fromElement == toElement ifTrue: [ ^ false ].
	(fromElement isNil or: [ toElement isNil ]) ifTrue: [ ^ false ].
	beDirectional ifFalse: [ ^ (toElement isDirectlyConnectedTo: fromElement) not ].
	allowRepetition ifFalse: [ ^ fromElement outgoingEdges noneSatisfy: [ :edge | edge to == toElement ] ].
	^ true
]

{ #category : #'public using source' }
TSEdgeBuilder >> source: objects connectFrom: fromblock to: toBlock [
	"Define some edges from objects that are not part of the view
	
nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | nodes atRandom -> nodes atRandom ].

b := RTMondrian new.

b shape circle color: (Color black alpha: 0.5).
b nodes: nodes.

b shape line color: (Color gray alpha: 0.3).
b edges
	source: edges connectFrom: #key to: #value.

b layout force.
b
	"
	| assocs allObjects |
	self assert: [ objects notNil ] description: 'Cannot provide a nil value as the source'.
	self assert: [ objects isCollection ] description: 'Need to provide a collection as the source'.
	allObjects := Set new.
	
	assocs := objects collect: [ :o | 
		| f t |
		f := fromblock rsValue: o.
		t := toBlock rsValue: o.
		allObjects add: f; add: t.
		f -> t ].
	self objects: allObjects asArray.
	^ self useAssociations: assocs
]

{ #category : #'public using source' }
TSEdgeBuilder >> source: objects connectFrom: fromblock toAll: toBlock [
	"Define some edges from objects that are not part of the view
	
nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | nodes atRandom -> {nodes atRandom . nodes atRandom} ].

b := RTMondrian new.

b shape circle color: (Color black alpha: 0.5).
b nodes: nodes.

b shape line color: (Color gray alpha: 0.3).
b edges
	source: edges connectFrom: #key toAll: #value.

b layout force.
b
	"
	| assocs allObjects |
	allObjects := Set new.

	assocs := objects flatCollect: [ :o | 
		| cc |
		cc := toBlock rsValue: o.
		cc collect: [ :ccc | 
			| t |
			t := fromblock rsValue: o.
			allObjects add: t; add: ccc.
			t -> ccc ] ].
	self objects: allObjects asArray.
	^ self useAssociations: assocs
]

{ #category : #'public using source' }
TSEdgeBuilder >> source: objects connectFromAll: fromBlock to: toBlock [
	"Define some edges from objects that are not part of the view
	
nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | {nodes atRandom . nodes atRandom} -> nodes atRandom ].

b := RTMondrian new.

b shape circle color: (Color black alpha: 0.5).
b nodes: nodes.

b shape line color: (Color gray alpha: 0.3).
b edges
	source: edges connectFromAll: #key to: #value.

b layout force.
b
	"
	| assocs allObjects |
	allObjects := Set new.

	assocs := objects flatCollect: [ :o | 
		| cc |
		cc := fromBlock rsValue: o.
		cc collect: [ :ccc | 
			| t |
			t := toBlock rsValue: o.
			allObjects add: ccc; add: t.
			ccc -> t ] ].
	self objects: allObjects asArray.
	^ self useAssociations: assocs
]

{ #category : #accessing }
TSEdgeBuilder >> toObject: anObject [
	^ self toObjects: (Array with: anObject)
]

{ #category : #accessing }
TSEdgeBuilder >> toObjects [
	"Return the list of objects considered as sources for the edges"
	^ self toShapes collect: #model
]

{ #category : #accessing }
TSEdgeBuilder >> toObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self toShapes: (canvas shapesFromModels: someObjectsOrABlock) ]
		ifFalse: [ self toShapes: (canvas nodes select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
]

{ #category : #accessing }
TSEdgeBuilder >> toShapes [
	toShapes ifNil: [ ^ self canvasNodes ].
	^ toShapes
]

{ #category : #accessing }
TSEdgeBuilder >> toShapes: someShapes [
	toShapes := someShapes asGroup
]

{ #category : #'public associations' }
TSEdgeBuilder >> useAssociation: assoc [
	"assoc have to be between model objects"
	| result |
	self assert: [ assoc isKindOf: Association ] description: 'Please, provide an association instead'.
	
	result := self useAssociations: (Array with: assoc).
	result ifEmpty: [ ^ nil ].
	^ result first
]

{ #category : #'public associations' }
TSEdgeBuilder >> useAssociations: associations [
	"associations have to be between model objects"
	
	"
	Here is an example
	
b := RTMondrian new.
b nodes: (1 to: 3).
b shape line
	color: Color red trans;
	withVerticallAttachPoint.
b edges noRepetition; useAssociations: { 1 -> 2 . 2 -> 3 . 1 -> 2}.
b layout grid.
b 

	"
	
	| fromElement toElement |
	createdEdges := RSGroup new.
	associations do: [ :assoc |
		fromElement := self fromShapes shapeFromModel: assoc key.
		toElement := self toShapes shapeFromModel: assoc value.
		(fromElement notNil and: [ toElement notNil ])
			ifTrue: [ self createEdgeIfNecessaryFrom: fromElement to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #'public associations' }
TSEdgeBuilder >> useElementAssociations: associationsBetweenElements [
	associationsBetweenElements do: [ :assoc |
		self edgeFrom: assoc key to: assoc value ]
]

{ #category : #'public - shape' }
TSEdgeBuilder >> width: aNumber [
	self shape width: aNumber
]

{ #category : #'public - attach point' }
TSEdgeBuilder >> withBorderAttachPoint [
	self attachPoint: RSBorderAttachPoint new.
]

{ #category : #'public - attach point' }
TSEdgeBuilder >> withVerticalAttachPoint [
	self attachPoint: RSVerticalAttachPoint new.
]
