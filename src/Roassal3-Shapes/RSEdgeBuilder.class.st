"
RSEdgeBuilder offers an API to easily build edges.

Here is an example:
```Smalltalk
c := RSCanvas new.

classes := Collection withAllSubclasses.
boxes := classes collect: [ :cls |
				RSBox new
					width: (cls instVarNames size * 5 max: 5);
					height: (cls numberOfMethods max: 5);
					model: cls;
					yourself ] as: RSGroup.


boxes @ RSDraggable.
c addAll: boxes.

RSEdgeBuilder orthoVertical
	canvas: c;
	attachPoint: RSVerticalAttachPoint new;
	shapes: boxes;
	connectFrom: #superclass.

RSTreeLayout on: c nodes.
c @ RSCanvasController.
c open
```

Another example:
```Smalltalk
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

lines := RSEdgeBuilder line
	canvas: c;
	connectFrom: 30 toAll: (31 to: 50).

lines do: [ :l | l attachPoint: (RSHorizontalAttachPoint new) ].

RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSCanvasController
```
"
Class {
	#name : #RSEdgeBuilder,
	#superclass : #RSObject,
	#traits : 'RSTEdge',
	#classTraits : 'RSTEdge classTrait',
	#instVars : [
		'shape',
		'allowRepetition',
		'shouldMoveBehind',
		'createdEdges',
		'beDirectional',
		'fromShapes',
		'toShapes',
		'canvas',
		'canvasHasBeenManuallySet'
	],
	#category : #'Roassal3-Shapes-Graph'
}

{ #category : #'instance creation' }
RSEdgeBuilder class >> arrowedLine [
	^ self new: RSShapeFactory arrowedLine
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> arrowedLineWithOffset [
	^ self arrowedLineWithOffset: 0.2
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> arrowedLineWithOffset: aFloat [
	"[0, 1] value"
	| inst |
	inst := self arrowedLine.
	inst shape markerEnd offsetRatio: aFloat.
	^ inst
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> bezier [
	^ self new: RSBezier new
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> horizontalBezier [
	^ self horizontalLine: RSBezier new
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> horizontalLine: aShape [
	^ (self new: aShape)
		controlPointsController: RSHorizontalCPAPController new;
		yourself.
	
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> line [
	^ self new: RSLine new
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> new [
	^ self error: 'Should not use #new to create an edge builder. Instead, use a #line, #arrowedLine.'
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> new: aRSShape [
	 ^ super new 
		shape: aRSShape;
		yourself
		
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> orthoHorizontal [
	^ self horizontalLine: RSPolyline new.
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> orthoVertical [
	^ self verticalLine: RSPolyline new.
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> polyline [
	^ self new: RSPolyline new
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> verticalBezier [
	^ self verticalLine: RSBezier new
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> verticalLine: aShape [
	^ (self new: aShape)
		controlPointsController: RSVerticalCPAPController new;
		yourself.
	
]

{ #category : #'public repetition' }
RSEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #'public - attach point' }
RSEdgeBuilder >> attachPoint [
	^ self shape attachPoint
]

{ #category : #'public - attach point' }
RSEdgeBuilder >> attachPoint: anAttachPoint [
	self shape attachPoint: anAttachPoint
]

{ #category : #'public - configuration' }
RSEdgeBuilder >> beDirectional [
	"When edges are created, this allow for having edges going from A to B, and from B to A"
	beDirectional := true
]

{ #category : #accessing }
RSEdgeBuilder >> canvas [
	^ canvas
]

{ #category : #accessing }
RSEdgeBuilder >> canvas: aCanvas [
	"Provide a reference to the Roassal canvas in which (i) shapes will be looked up and (ii) lines will be added"
	canvasHasBeenManuallySet := true.
	canvas := aCanvas
]

{ #category : #accessing }
RSEdgeBuilder >> canvasNodes [
	"Return the nodes of the canvas"
	canvas ifNil: [ ^ #() ].
	^ canvas nodes
]

{ #category : #public }
RSEdgeBuilder >> connectFrom: aBlockOrASymbol [
	"Connect each shapes with the shapes for which the model matches aBlockOrASymbol"
	^ self connectFrom: aBlockOrASymbol to: [ :each | each ]
]

{ #category : #public }
RSEdgeBuilder >> connectFrom: aFromBlock to: aBlockOrASymbol [
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
RSEdgeBuilder >> connectFrom: aFromBlock toAll: aBlockOrASymbol [
	"Define edges from a particular element to another set of elements. For example:

-=-=-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

RSEdgeBuilder line
	canvas: c;
	withBorderAttachPoint;
	connectFrom: 30 toAll: (31 to: 50).


RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSControlsCanvas
-=-=-=-=-=-=-=-=-=-=-=-=
	"

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
RSEdgeBuilder >> connectFromAll: aFromBlockOrSymbol [
	^ self connectFromAll: aFromBlockOrSymbol to: [ :each | each ]

]

{ #category : #public }
RSEdgeBuilder >> connectFromAll: aFromBlockOrSymbol to: aBlockOrASymbol [

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
RSEdgeBuilder >> connectTo: aBlockOrASymbol [
	^ self connectFrom: [ :each | each ] to: aBlockOrASymbol
]

{ #category : #public }
RSEdgeBuilder >> connectToAll: aBlockOrASymbol [
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

{ #category : #'private - utility' }
RSEdgeBuilder >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	"This is a private method. Create, if necessary, an edge between two elements"
	(self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ createdEdges add: (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'private - utility' }
RSEdgeBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| edge |
	edge := self shape copy
		model: source model -> target model;
		from: source;
		to: target;
		yourself.
	edge border: (self shape border copy).
	canvas ifNotNil: [ canvas add: edge ].
	^ edge
]

{ #category : #accessing }
RSEdgeBuilder >> fromObjects [
	"Return the list of objects considered as targets for the edges"
	^ self fromShapes collect: #model
]

{ #category : #accessing }
RSEdgeBuilder >> fromObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self fromShapes: (canvas shapesFromModels: someObjectsOrABlock) ]
		ifFalse: [ self fromShapes: (canvas nodes select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
]

{ #category : #accessing }
RSEdgeBuilder >> fromShapes [
	fromShapes ifNil: [ ^ self canvasNodes ].
	^ fromShapes
]

{ #category : #accessing }
RSEdgeBuilder >> fromShapes: someShapes [
	fromShapes := someShapes asGroup
]

{ #category : #initialization }
RSEdgeBuilder >> initialize [
	super initialize.
	self noRepetition.
	shouldMoveBehind := false.
	
	"The view has to be explicitly set by the end-user"
	canvasHasBeenManuallySet := false.
	"We could have edges from A to B, and from B to A"
	self beDirectional.
]

{ #category : #testing }
RSEdgeBuilder >> isBidirectional [
	"Return true or false, indicating whether the edge builder is bidirectional or not (i.e., if 
	edges from A to B, __and__ B to A can be created"
	^ beDirectional 
]

{ #category : #accessing }
RSEdgeBuilder >> moveBehind [
	"Set the builder as such that edge that are built and added in the view _behind_ the extremities of each edges"
	shouldMoveBehind := true
]

{ #category : #'private - utility' }
RSEdgeBuilder >> moveBehindIfNecessary: someEdges [
	shouldMoveBehind ifFalse: [ ^ self ].
	someEdges pushBack
]

{ #category : #'public - configuration' }
RSEdgeBuilder >> noBidirectional [
	"When edges are created, this does not allow for having edges going from A to B, and from B to A. Only A to B, __OR__, B to A is created"
	beDirectional := false
]

{ #category : #'public - configuration' }
RSEdgeBuilder >> noRepetition [
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
RSEdgeBuilder >> object: anObject [
	^ self objects: (Array with: anObject)
]

{ #category : #accessing }
RSEdgeBuilder >> objects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	self toObjects: someObjectsOrABlock.
	self fromObjects: someObjectsOrABlock.
]

{ #category : #'private - utility' }
RSEdgeBuilder >> resetCreatedEdges [
	createdEdges := RSGroup new
]

{ #category : #'public - shape' }
RSEdgeBuilder >> shape [
	^ shape
]

{ #category : #'public - shape' }
RSEdgeBuilder >> shape: aRSShape [
	"Set the shape used to build edges"
	self assert: aRSShape isEdge.
	shape := aRSShape
]

{ #category : #accessing }
RSEdgeBuilder >> shapes: someShapes [
	self toShapes: someShapes.
	self fromShapes: someShapes
]

{ #category : #'public repetition' }
RSEdgeBuilder >> shouldAllowRepetition [
	^ allowRepetition
]

{ #category : #testing }
RSEdgeBuilder >> shouldCreateEdgeFrom: fromElement to: toElement [
	"Return true if an edge has to be created"
	fromElement == toElement ifTrue: [ ^ false ].
	(fromElement isNil or: [ toElement isNil ]) ifTrue: [ ^ false ].
	beDirectional ifFalse: [ ^ (toElement isDirectlyConnectedTo: fromElement) not ].
	allowRepetition ifFalse: [ ^ fromElement outgoingEdges noneSatisfy: [ :edge | edge to == toElement ] ].
	^ true
]

{ #category : #'public using source' }
RSEdgeBuilder >> source: objects connectFrom: fromblock to: toBlock [
	"Define some edges from objects that are not part of the canvas"
	"
	nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | nodes atRandom -> nodes atRandom ].

b := RSCanvas new .

b addAll: (nodes collect: [ :n|
	RSEllipse new
		model: n;
		size: 5;
		color: (Color black alpha: 0.5)]).

RSEdgeBuilder line
	color: (Color gray alpha: 0.3);
	canvas: b;
	source: edges connectFrom: #key to: #value.

RSForceBasedLayout on: b nodes.
b"
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
RSEdgeBuilder >> source: objects connectFrom: fromblock toAll: toBlock [
	"Define some edges from objects that are not part of the view
	
nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | nodes atRandom -> {nodes atRandom . nodes atRandom} ].

b := RSCanvas new .

b addAll: (nodes collect: [ :n|
	RSEllipse new
		model: n;
		size: 5;
		color: (Color black alpha: 0.5)]).

RSEdgeBuilder line
	color: (Color gray alpha: 0.3);
	canvas: b;
	source: edges connectFrom: #key toAll: #value.

RSForceBasedLayout on: b nodes.
b"
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
RSEdgeBuilder >> source: objects connectFromAll: fromBlock to: toBlock [
	"Define some edges from objects that are not part of the view
	
nbOfNodes := 40.
nbOfRandomEdges := 40.

nodes := 1 to: nbOfNodes.
edges := (1 to: nbOfRandomEdges) 
				collect: [ :notUsed | {nodes atRandom . nodes atRandom} -> nodes atRandom ].

b := RSCanvas new .

b addAll: (nodes collect: [ :n|
	RSEllipse new
		model: n;
		size: 5;
		color: (Color black alpha: 0.5)]).

RSEdgeBuilder line
	color: (Color gray alpha: 0.3);
	canvas: b;
	source: edges connectFromAll: #key to: #value.

RSForceBasedLayout on: b nodes.
b"
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
RSEdgeBuilder >> toObject: anObject [
	^ self toObjects: (Array with: anObject)
]

{ #category : #accessing }
RSEdgeBuilder >> toObjects [
	"Return the list of objects considered as sources for the edges"
	^ self toShapes collect: #model
]

{ #category : #accessing }
RSEdgeBuilder >> toObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ canvasHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self toShapes: (canvas shapesFromModels: someObjectsOrABlock) ]
		ifFalse: [ self toShapes: (canvas nodes select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
]

{ #category : #accessing }
RSEdgeBuilder >> toShapes [
	toShapes ifNil: [ ^ self canvasNodes ].
	^ toShapes
]

{ #category : #accessing }
RSEdgeBuilder >> toShapes: someShapes [
	toShapes := someShapes asGroup
]

{ #category : #'public associations' }
RSEdgeBuilder >> useAssociation: assoc [
	"assoc have to be between model objects"
	| result |
	self assert: [ assoc isKindOf: Association ] description: 'Please, provide an association instead'.
	
	result := self useAssociations: (Array with: assoc).
	result ifEmpty: [ ^ nil ].
	^ result first
]

{ #category : #'public associations' }
RSEdgeBuilder >> useAssociations: associations [
	"Draw edges between shapes using associations. Each association has to follow the pattern: startmodel -> endmodel
	
For example
-=-=-=-=-=-=-=-=-=
b := RSCanvas  new.
b addAll: ((1 to: 3) collect: [:i |
	RSEllipse new
		model: i;
		size: 5]).

RSEdgeBuilder line
	color: Color red translucent;
	canvas: b;
	withVerticalAttachPoint;
	noRepetition;
	useAssociations: { 1 -> 2 . 2 -> 3 . 1 -> 2}.
RSGridLayout on: b nodes.
b @ RSCanvasController
-=-=-=-=-=-=-=-=-=
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
RSEdgeBuilder >> useElementAssociations: associationsBetweenElements [
	associationsBetweenElements do: [ :assoc |
		self edgeFrom: assoc key to: assoc value ]
]

{ #category : #'public - attach point' }
RSEdgeBuilder >> withBorderAttachPoint [
	"Make the produced line use a border attach point. For example:
-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

from := RSBox new size: 30; model: 'from'.
to := RSEllipse new size: 30; model: 'to'.

c add: from.
c add: to.

RSEdgeBuilder line
	canvas: c;
	withBorderAttachPoint;
	connectFrom: 'from' to: 'to'.


from @ RSDraggable.
to @ RSDraggable.

to translateTo: 50 @ 40.

c @ RSCanvasController
-=-=-=-=-=-=-=-=-=-=
	"
	self attachPoint: RSBorderAttachPoint new.
]

{ #category : #'public - attach point' }
RSEdgeBuilder >> withHorizontalAttachPoint [
	"Make the produced line use a vertical attach point. For example:
-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

from := RSBox new size: 30; model: 'from'.
to := RSEllipse new size: 30; model: 'to'.

c add: from.
c add: to.

RSEdgeBuilder line
	canvas: c;
	withHorizontalAttachPoint;
	connectFrom: 'from' to: 'to'.


from @ RSDraggable.
to @ RSDraggable.

to translateTo: 50 @ 40.

c @ RSCanvasController
-=-=-=-=-=-=-=-=-=-=
	"
	self attachPoint: RSHorizontalAttachPoint new.
]

{ #category : #'public - attach point' }
RSEdgeBuilder >> withVerticalAttachPoint [
	"Make the produced line use a vertical attach point. For example:
-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

from := RSBox new size: 30; model: 'from'.
to := RSEllipse new size: 30; model: 'to'.

c add: from.
c add: to.

RSEdgeBuilder line
	canvas: c;
	withVerticalAttachPoint;
	connectFrom: 'from' to: 'to'.


from @ RSDraggable.
to @ RSDraggable.

to translateTo: 50 @ 40.

c @ RSCanvasController
-=-=-=-=-=-=-=-=-=-=
	"
	self attachPoint: RSVerticalAttachPoint new.
]
