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
	#name : #RSEdgeBuilder,
	#superclass : #RSSingleEdgeBuilder,
	#instVars : [
		'view',
		'allowRepetition',
		'fromElements',
		'toElements',
		'shouldMoveBehind',
		'shouldNotBeUsedInLayout',
		'createdEdges',
		'viewHasBeenManuallySet',
		'beDirectional'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #'public repetition' }
RSEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #'public - configuration' }
RSEdgeBuilder >> beDirectional [
	"When edges are created, this allow for having edges going from A to B, and from B to A"
	beDirectional := true
]

{ #category : #public }
RSEdgeBuilder >> connectFrom: aBlockOrASymbol [
	^ self connectFrom: aBlockOrASymbol to: [ :each | each ]
]

{ #category : #public }
RSEdgeBuilder >> connectFrom: aFromBlock to: aBlockOrASymbol [
	| toElement fromElement |
	self resetCreatedEdges.
	self fromElements copy
		do: [ :e | 
			fromElement := self fromElements elementFromModel: (aFromBlock rsValue: e model).
			toElement := self toElements elementFromModel: (aBlockOrASymbol rsValue: e model).
			toElement ifNotNil: [ self createEdgeIfNecessaryFrom: fromElement to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
RSEdgeBuilder >> connectFrom: aFromBlock toAll: aBlockOrASymbol [

	| fromElement tes |
	self resetCreatedEdges.
	self fromElements copy do: [ :e | 
		fromElement := self fromElements elementFromModel: (aFromBlock rsValue: e model).
		tes := self toElements elementsFromModels: (aBlockOrASymbol rsValue: e model).
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
	self fromElements copy do: [ :e | 
		tfromElements := self fromElements elementsFromModels: (aFromBlockOrSymbol rsValue: e model). 
		toElement := self toElements elementFromModel: (aBlockOrASymbol rsValue: e model).
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
	self fromElements copy do: [ :e | 
		tmptoElements := self toElements elementsFromModels: (aBlockOrASymbol rsValue: e model).
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
	self from: source; to: target.
	edge := self edge. 
	view ifNotNil: [ view add: edge ].
	shouldNotBeUsedInLayout ifFalse: [ edge notUseInLayout ].
	^ edge
]

{ #category : #accessing }
RSEdgeBuilder >> elements: someElements [
	self toElements: someElements.
	self fromElements: someElements
]

{ #category : #accessing }
RSEdgeBuilder >> fromElements [
	fromElements ifNil: [ ^ self viewElements  ].
	^ fromElements
]

{ #category : #accessing }
RSEdgeBuilder >> fromElements: someElements [
	fromElements := someElements
]

{ #category : #accessing }
RSEdgeBuilder >> fromObjects [
	"Return the list of objects considered as targets for the edges"
	^ self fromElements collect: #model
]

{ #category : #accessing }
RSEdgeBuilder >> fromObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self fromElements: (view elementsFromModels: someObjectsOrABlock) ]
		ifFalse: [ self fromElements: (view elements select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
]

{ #category : #initialization }
RSEdgeBuilder >> initialize [
	super initialize.
	self noRepetition.
	shouldMoveBehind := false.
	shouldNotBeUsedInLayout := true.
	
	"The view has to be explicitly set by the end-user"
	viewHasBeenManuallySet := false.
	
	"We could have edges from A to B, and from B to A"
	self beDirectional
]

{ #category : #testing }
RSEdgeBuilder >> isBidirectional [
	"Return true or false, indicating whether the edge builder is bidirectional or not (i.e., if 
	edges from A to B, __and__ B to A can be created"
	^ beDirectional 
]

{ #category : #'private - utility' }
RSEdgeBuilder >> linkElements: someElements [
	"Link the first element to the second, the second to the third and so on"
	| head |
	head := someElements first.
	someElements allButFirst do: [ :e |
		self edgeFrom: head to: e.
		head := e.
		]
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

{ #category : #'public - configuration' }
RSEdgeBuilder >> notUseInLayout [
	"Indicate that the edges should not be used in the layout.
The following example shows that the layout is driven only by the red lines, and not the blue ones:

b := RTMondrian new.
b nodes: RTShape withAllSubclasses.

b shape line color: Color red trans.
b edges connectFrom: #superclass.

b shape line color: Color blue trans.
b edges
	notUseInLayout;
	connectToAll: #dependentClasses.

b layout tree.
b

	
	"
	shouldNotBeUsedInLayout := false
]

{ #category : #accessing }
RSEdgeBuilder >> object: anObject [
	^ self objects: (Array with: anObject)
]

{ #category : #accessing }
RSEdgeBuilder >> objects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	self toObjects: someObjectsOrABlock.
	self fromObjects: someObjectsOrABlock.
]

{ #category : #'private - utility' }
RSEdgeBuilder >> resetCreatedEdges [
	createdEdges := TSGroup new
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
RSEdgeBuilder >> source: objects connectFrom: fromblock toAll: toBlock [
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
RSEdgeBuilder >> source: objects connectFromAll: fromBlock to: toBlock [
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
RSEdgeBuilder >> toElements [
	toElements ifNil: [ ^ self viewElements ].
	^ toElements
]

{ #category : #accessing }
RSEdgeBuilder >> toElements: someElements [
	toElements := someElements
]

{ #category : #accessing }
RSEdgeBuilder >> toObject: anObject [
	^ self toObjects: (Array with: anObject)
]

{ #category : #accessing }
RSEdgeBuilder >> toObjects [
	"Return the list of objects considered as sources for the edges"
	^ self toElements collect: #model
]

{ #category : #accessing }
RSEdgeBuilder >> toObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self toElements: (view elementsFromModels: someObjectsOrABlock) ]
		ifFalse: [ self toElements: (view elements select: [ :el | someObjectsOrABlock rsValue: el model ]) ]
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
	createdEdges := TSGroup new.
	associations do: [ :assoc |
		fromElement := self fromElements elementFromModel: assoc key.
		toElement := self toElements elementFromModel: assoc value.
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

{ #category : #accessing }
RSEdgeBuilder >> view [
	^ view
]

{ #category : #accessing }
RSEdgeBuilder >> view: aView [
	viewHasBeenManuallySet := true.
	view := aView
]

{ #category : #accessing }
RSEdgeBuilder >> viewElements [
	view ifNil: [ ^ #() ].
	^ view elements.
]
