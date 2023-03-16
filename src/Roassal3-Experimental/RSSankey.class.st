"
I represent a Sankey chart.

I am reimplemented the sankey code from D3 for smalltalk-pharo and some of their examples.

https://www.d3-graph-gallery.com/sankey
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

{ #category : #'instance creation' }
RSSankey class >> withAllAssociations: aCollection [

	^ self withAllLinks: (aCollection collect: [ :eachAssociation |
			   RSSankeyLink on: eachAssociation ])
]

{ #category : #'instance creation' }
RSSankey class >> withAllLinks: aCollection [

	^ self new
		  links: aCollection;
		  nodes: (aCollection
				   flatCollect: [ :eachLink |
					   {
						   eachLink from.
						   eachLink to } ]
				   as: OrderedCollection) removeDuplicates
]

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
RSSankey >> boxesByBreadth [

	| boxesByBreadth |
	boxesByBreadth := boxes groupedBy: [ :eachBox | eachBox x ].
	boxesByBreadth := boxesByBreadth keysSortedSafely collect: [
		                  :eachBreadth | boxesByBreadth at: eachBreadth ].
	^ boxesByBreadth
]

{ #category : #private }
RSSankey >> computeBoxesBreadths [

	| remainingBoxes nextBoxes x kx |
	x := 0.
	remainingBoxes := boxes.
	[ remainingBoxes notEmpty and: [ x < boxes size ] ] whileTrue: [
		nextBoxes := OrderedCollection new.
		remainingBoxes do: [ :box |
			box x: x.
			nextBoxes addAll: (box sourceLinks
					 collect: [ :eachLink | eachLink to ]
					 thenReject: [ :eachBox | nextBoxes includes: eachBox ]) ].
		remainingBoxes := nextBoxes.
		x := x + 1 ].

	kx := extent x / (x - 1).
	boxes do: [ :box |
		box sourceLinks ifEmpty: [ box x: x - 1 ].
		box x: box x * kx ]
]

{ #category : #private }
RSSankey >> computeBoxesDepths [

	| boxesByBreadth alpha |
	boxesByBreadth := self boxesByBreadth.
	boxesByBreadth ifEmpty: [ ^ self ].
	boxesByBreadth last do: [ :eachBox | eachBox last: true ].
	self setupBoxesDepth: boxesByBreadth.
	self resolveCollisions: boxesByBreadth.
	self computeLinesDepths.
	alpha := 1.
	self iterations timesRepeat: [
		alpha := alpha * 0.99.
		self relaxRightToLeft: alpha boxes: boxesByBreadth.
		self resolveCollisions: boxesByBreadth.
		self computeLinesDepths.
		self relaxLeftToRight: alpha boxes: boxesByBreadth.
		self resolveCollisions: boxesByBreadth.
		self computeLinesDepths ]
]

{ #category : #private }
RSSankey >> computeBoxesValues [

	boxes do: [ :eachBox | eachBox computeValue ]
]

{ #category : #private }
RSSankey >> computeLinesDepths [

	boxes do: [ :eachBox | eachBox computeLinesDepths ]
]

{ #category : #private }
RSSankey >> computeSankey [

	self
		computeBoxesValues;
		computeBoxesBreadths;
		computeBoxesDepths;
		computeLinesDepths
]

{ #category : #hooks }
RSSankey >> createBoxes [

	^ nodes
		  collect: [ :node |
			  boxShape copyWithAnnouncer
				  model: node;
				  color: (boxColor rsValue: node);
				  sourceLinks: OrderedCollection new;
				  targetLinks: OrderedCollection new;
				  yourself ]
		  as: RSGroup
]

{ #category : #hooks }
RSSankey >> createLabels [

	^ nodes collect: [ :node |
		  labelShape copyWithAnnouncer
			  model: node;
			  text: node asString;
			  yourself ]
]

{ #category : #hooks }
RSSankey >> createLines [

	^ links collect: [ :link |
		  | sourceBox targetBox line |
		  sourceBox := boxes shapeFromModel: link from.
		  targetBox := boxes shapeFromModel: link to.
		  line := lineShape copyWithAnnouncer
			          from: sourceBox;
			          to: targetBox;
			          model: link;
			          border: lineShape border copy;
			          value: link value;
			          yourself.
		  sourceBox sourceLinks in: [ :list | list add: line ].
		  targetBox targetLinks in: [ :list | list add: line ].
		  line ]
]

{ #category : #defaults }
RSSankey >> defaultContainer [

	^ RSCanvas new @ RSCanvasController
]

{ #category : #defaults }
RSSankey >> defaultLineColor [

	^ Color lightGray translucent
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
	boxShape := RSSankeyBox new.
	boxShape @ RSDraggable.
	labelShape := RSLabel new.
	lineShape := RSSankeyLine new.
	lineShape color: self defaultLineColor.
	lineShape controlPointsController: RSSankeyCPController new.
	self nodePadding: 0
]

{ #category : #accessing }
RSSankey >> iterations [

	^ iterations ifNil: 1
]

{ #category : #accessing }
RSSankey >> iterations: aNumber [

	iterations := aNumber
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
RSSankey >> links: aCollection [

	links := aCollection
]

{ #category : #accessing }
RSSankey >> nodePadding [

	^ nodePadding
]

{ #category : #accessing }
RSSankey >> nodePadding: aNumber [

	nodePadding := aNumber
]

{ #category : #accessing }
RSSankey >> nodes [

	^ nodes
]

{ #category : #accessing }
RSSankey >> nodes: aCollection [

	nodes := aCollection asOrderedCollection
]

{ #category : #private }
RSSankey >> relaxLeftToRight: alpha boxes: boxesByBreadth [

	boxesByBreadth flattened do: [ :eachBox |
		eachBox relaxLeftToRight: alpha ]
]

{ #category : #private }
RSSankey >> relaxRightToLeft: alpha boxes: boxesByBreadth [

	boxesByBreadth reversed flattened do: [ :eachBox |
		eachBox relaxRightToLeft: alpha ]
]

{ #category : #hooks }
RSSankey >> renderIn: aCanvas [

	nodes ifNil: [ ^ self ].
	boxes := self createBoxes.
	lines := self createLines.
	labels := self createLabels.

	aCanvas
		addAll: lines;
		addAll: boxes;
		addAll: labels.
	self computeSankey.
	self updateBoxes
]

{ #category : #private }
RSSankey >> resolveCollisions: boxesByBreadth [

	| list node dy y0 |
	boxesByBreadth do: [ :array |
		y0 := 0.
		list := array sorted: [ :a :b | a y < b y ].
		list do: [ :n |
			node := n.
			dy := y0 - node y.
			dy > 0 ifTrue: [ node y: node y + dy ].
			y0 := node y + nodePadding + node dy ].
		"If bottommost node goes outside the bounds push it back up"
		dy := y0 - nodePadding - extent y.
		dy > 0 ifTrue: [
			y0 := node y: node y - dy.
			y0 := node y.
			(list size - 1 to: 1 by: -1) do: [ :i |
				node := list at: i.
				dy := node y + node dy + nodePadding - y0.
				dy > 0 ifTrue: [ node y: node y - dy ].
				y0 := node y ] ] ]
]

{ #category : #private }
RSSankey >> setupBoxesDepth: boxesByBreadth [

	| ky |
	ky := boxesByBreadth inject: Float fmax into: [ :min :arr |
		      min min: extent y - (arr size - 1 * nodePadding)
			      / (arr inject: 0 into: [ :sum :box | box value + sum ]) ].
	boxesByBreadth do: [ :arr |
		arr doWithIndex: [ :box :i |
			box
				y: i - 1;
				dy: box value * ky ] ].
	lines do: [ :line | line dy: line value * ky ]
]

{ #category : #private }
RSSankey >> updateBoxes [

	| side |
	boxes doWithIndex: [ :box :i |
		| label sign |
		label := labels at: i.

		box translateTo: box x @ box center.
		box height: box dy.
		sign := 1.
		side := box last
			        ifTrue: [ #left ]
			        ifFalse: [ #right ].
		side = #right ifTrue: [ sign := -1 ].
		RSLocation new
			outer;
			in: [ :loc | side value: loc ];
			middle;
			offset: -5 @ 0 * sign;
			stick: label on: box ].
	lines ifNil: [ ^ self ].
	lines do: [ :line | line width: ((line dy ifNil: [ 1 ]) max: 1) ]
]
