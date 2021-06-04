"
TODO
"
Class {
	#name : #RSSankey,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'extent',
		'nodePadding',
		'nodes',
		'links',
		'boxShape',
		'iterations',
		'boxes',
		'labels',
		'labelShape',
		'lineShape',
		'lines',
		'boxColor'
	],
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #accessing }
RSSankey >> boxColor [

	^ boxColor
]

{ #category : #accessing }
RSSankey >> boxColor: anObject [

	boxColor := anObject
]

{ #category : #accessing }
RSSankey >> boxShape [
	^ boxShape
]

{ #category : #accessing }
RSSankey >> boxes [
	^ boxes
]

{ #category : #private }
RSSankey >> centerOf: box [
	^ (box propertyAt: #y) + ((box propertyAt: #dy) /2 )
]

{ #category : #private }
RSSankey >> computeBoxesBreadths [
	| remainingBoxes nextBoxes x kx |
	x := 0.
	remainingBoxes := boxes.
	[ remainingBoxes size isZero ] whileFalse: [ 
		nextBoxes := OrderedCollection new.
		remainingBoxes do: [ :box |
			box propertyAt: #x put: x.
			nextBoxes addAll: ((box propertyAt: #sourceLinks) collect: #to) ].
		remainingBoxes := nextBoxes.
		x := x + 1.
	 ].
	
	kx := extent x / (x - 1).
	boxes do: [ :box | | x1 |
		(box propertyAt: #sourceLinks) ifEmpty: [ 
			box propertyAt: #x put: x - 1.
			 ].
		x1 := box propertyAt: #x.
		box propertyAt: #x put: x1 * kx
		 ]
]

{ #category : #private }
RSSankey >> computeBoxesDepths [
	| boxesByBreadth alpha |
	boxesByBreadth := boxes groupedBy: [ :e | e propertyAt: #x ].
	boxesByBreadth := boxesByBreadth keysSortedSafely 
		collect: [:k | boxesByBreadth at: k ].
	boxesByBreadth ifEmpty: [ ^ self ].
	boxesByBreadth last do: [ :e |
		e propertyAt: #last put: true ].
	self setupBoxesDepth: boxesByBreadth.
	self resolveCollisions: boxesByBreadth.
	alpha := 1.
	1 to: iterations do: [ :i |
		self relaxRightToLeft: (alpha := alpha *0.99) boxes: boxesByBreadth.
		self resolveCollisions: boxesByBreadth.
		self relaxLeftToRight: alpha boxes: boxesByBreadth.
		self resolveCollisions: boxesByBreadth.]
	
]

{ #category : #private }
RSSankey >> computeBoxesValues [
	boxes do: [ :box | | fromLinks toLinks |
		fromLinks := box propertyAt: #sourceLinks.
		toLinks := box propertyAt: #targetLinks.
		box propertyAt: #value put: ((self sum: fromLinks) max: (self sum: toLinks))
	]
]

{ #category : #private }
RSSankey >> computeLinesDepths [
	boxes do: [ :box |
		(box propertyAt: #sourceLinks) sort: [:a :b | 
			(a to propertyAt: #y) < (b from propertyAt: #y) ].
		(box propertyAt: #targetLinks) sort:  [ :a :b | 
			(a from propertyAt: #y) < (b to propertyAt: #y) ].
		 ].
	boxes do: [ :box | | sy ty|
		sy := ty := 0.
		(box propertyAt: #sourceLinks) do: [ :line |
			line propertyAt: #sy put: sy.
			sy := sy + (line propertyAt: #dy) ].
		(box propertyAt: #targetLinks) do: [ :line |
			line propertyAt: #ty put: ty.
			ty := ty + (line propertyAt: #dy) ].
		 ].
	
]

{ #category : #private }
RSSankey >> computeSankey [
	self
		computeBoxesValues;
		computeBoxesBreadths;
		computeBoxesDepths;
		computeLinesDepths.
		
]

{ #category : #hooks }
RSSankey >> createBoxes [
	^ nodes collect: [ :node | 
		boxShape copyWithAnnouncer
			model: node;
			color: (boxColor rsValue: node);
			propertyAt: #sourceLinks put: OrderedCollection new;
			propertyAt: #targetLinks put: OrderedCollection new;
			yourself
		] as: RSGroup.
]

{ #category : #hooks }
RSSankey >> createLabels [
	^ nodes collect: [ :node | 
		labelShape copyWithAnnouncer
			model: node;
			text: node asString;
			yourself
		].
]

{ #category : #hooks }
RSSankey >> createLines [
	^ links collect: [ :link | | b1 b2 line |
		b1 := boxes shapeFromModel: link from.
		b2 := boxes shapeFromModel: link to.
		line := lineShape copyWithAnnouncer
			from: b1;
			to: b2;
			model: link;
			border: lineShape border copy;
			propertyAt: #value put: link value;
			yourself.
		(b1 propertyAt: #sourceLinks) in: [ :list | list add: line ].
		(b2 propertyAt: #targetLinks) in: [ :list | list add: line ].
		line
		].
]

{ #category : #defaults }
RSSankey >> defaultContainer [
	^ RSCanvas new @ RSCanvasController 
]

{ #category : #accessing }
RSSankey >> extent [

	^ extent
]

{ #category : #accessing }
RSSankey >> extent: anObject [

	extent := anObject
]

{ #category : #initialization }
RSSankey >> initialize [
	super initialize.
	boxShape := RSBox new.
	boxShape @ RSDraggableInteraction.
	labelShape := RSLabel new.
	lineShape := RSBezier new.
	lineShape color: Color lightGray translucent.
	lineShape controlPointsController: RSSankeyCPController new.
	self nodePadding: 0.
]

{ #category : #accessing }
RSSankey >> iterations [

	^ iterations
]

{ #category : #accessing }
RSSankey >> iterations: anObject [

	iterations := anObject
]

{ #category : #accessing }
RSSankey >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RSSankey >> labels [
	^ labels
]

{ #category : #accessing }
RSSankey >> lineShape [
	^ lineShape
]

{ #category : #accessing }
RSSankey >> lines [
	^ lines
]

{ #category : #accessing }
RSSankey >> links [

	^ links
]

{ #category : #accessing }
RSSankey >> links: anObject [

	links := anObject
]

{ #category : #accessing }
RSSankey >> nodePadding [

	^ nodePadding
]

{ #category : #accessing }
RSSankey >> nodePadding: anObject [

	nodePadding := anObject
]

{ #category : #accessing }
RSSankey >> nodes [

	^ nodes
]

{ #category : #accessing }
RSSankey >> nodes: anObject [

	nodes := anObject
]

{ #category : #private }
RSSankey >> relaxLeftToRight: alpha boxes: boxesByBreadth [
	| tl y |
	boxesByBreadth do: [ :list|
		list do: [ :box |
			tl := box propertyAt: #targetLinks.
			tl ifNotEmpty: [ 
				y := (tl sum: [:line | self weightedSourceOf: line])
					/ (tl sum: [:line | self valueOf: line]).
				box propertyAt: #y put: (box propertyAt: #y) + ((y - (self centerOf: box))*alpha) ] ] ]
]

{ #category : #private }
RSSankey >> relaxRightToLeft: alpha boxes: boxesByBreadth [
	| sl y |
	boxesByBreadth reversed do: [ :list | 
		list do: [ :box | 
			sl := box propertyAt: #sourceLinks.
			sl ifNotEmpty: [ 
				y := (sl sum: [:line | self weightedTargetOf: line])
					/ (sl sum: [:line | self valueOf: line ]).
				box propertyAt: #y put: (box propertyAt: #y) + ((y - (self centerOf: box)) * alpha) ] ].
	 ].
]

{ #category : #hooks }
RSSankey >> renderIn: aCanvas [
	nodes ifNil: [ ^ self ].
	boxes := self createBoxes.
	lines := self createLines.
	labels := self createLabels.

	aCanvas addAll: lines; addAll: boxes; addAll: labels.
	self computeSankey.
	self updateBoxes.
]

{ #category : #private }
RSSankey >> resolveCollisions: boxesByBreadth [
	| list node dy y0 i |
	
	boxesByBreadth do: [ :array |
		y0 := 0.
		list := array sorted: [ :a :b | (self yOf: a) < (self yOf: b) ].
		list do: [ :n |
			node := n.
			dy :=  y0 - (self yOf: node).
			dy > 0 ifTrue: [ node propertyAt: #y put: (self yOf: node) + dy ].
			y0 := (self yOf: node) + nodePadding + (node propertyAt: #dy).  ].
		"If bottommost node goes outside the bounds push it back up"
		dy := y0 - nodePadding - extent y.
		dy > 0 ifTrue: [ 
			y0 := node propertyAt: #y put: (self yOf: node) - dy.
			i := list size - 1.
			[ i >= 1  ] whileTrue: [
				node := list at: i.
				dy := (self yOf: node) + (node propertyAt: #dy) +  nodePadding - y0.
				dy > 0 ifTrue: [ node propertyAt: #y put: (self yOf: node) - dy ].
				y0 := self yOf: node.
				i := i - 1 ] ] ].
	
]

{ #category : #private }
RSSankey >> setupBoxesDepth: boxesByBreadth [
	| ky |
	ky := boxesByBreadth inject: Float fmax into: [ :min :arr |
		min min: ((extent y - ((arr size - 1) * nodePadding ))/ 
		(arr inject: 0 into: [ :sum :box | (self valueOf: box) + sum])) ].
	boxesByBreadth do: [ :arr | 
		arr doWithIndex: [ :box :i| 
			box
				propertyAt: #y put: i - 1;
				propertyAt: #dy put: (self valueOf: box)*ky ].
		].
	lines do: [ :line | line propertyAt: #dy put: (self valueOf: line)*ky ].
]

{ #category : #private }
RSSankey >> sum: aCollection [
	^ aCollection inject: 0 into: [ :s :l | (self valueOf: l) + s ]
]

{ #category : #private }
RSSankey >> updateBoxes [
	| prop dy x y side |
	boxes doWithIndex: [ :box :i | 
		| label sign |
		label := labels at: i. 
		prop := box properties.
		dy := prop at: #dy.
		x := prop at: #x.
		y := prop at: #y.
		
		box translateTo: x @ (y+(dy/2)).
		box height: dy.
		sign := 1.
		side := (prop includesKey: #last) 
			ifTrue: [ #left ] 
			ifFalse: [ #right ].
		side = #right ifTrue: [ sign := -1 ].
		RSLocation new
			outer;
			in: [ :loc | side value: loc ];
			middle;
			offset: (-5@ 0) * sign; 
			stick: label on: box
		
		 ].
	lines ifNil: [ ^ self ].
	lines do: [ :line | line width: ((line propertyAt: #dy ifAbsent: [ 1 ]) max: 1) ].
]

{ #category : #private }
RSSankey >> valueOf: shape [
	^ shape propertyAt: #value
]

{ #category : #private }
RSSankey >> weightedSourceOf: line [ 
	^ (self centerOf: line from) * (self valueOf: line)
]

{ #category : #private }
RSSankey >> weightedTargetOf: line [ 
	^ (self centerOf: line to) * (self valueOf: line)
]

{ #category : #private }
RSSankey >> yOf: shape [
	^ shape propertyAt: #y
]
