"
I am a layout that uses forces in each elements, I have create a light representation of one element.
For example:
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.
c addAll: ((1 to: 100) collect: [:i | RSEllipse new size: 10; model: i]).

eb := RSEdgeBuilder line.
eb canvas: c.
eb connectFrom: [ :v | v // 2 ].

RSForceBasedLayout on: c nodes.
c
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSForceBasedLayout,
	#superclass : #RSEdgeDrivenLayout,
	#instVars : [
		'iterations',
		'nodes',
		'initialLayout',
		'gravity',
		'friction',
		'theta',
		'strength',
		'length',
		'charge',
		'center',
		'alpha',
		'shouldUseProgressBar',
		'random',
		'quadtree'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSForceBasedLayout >> accumulate: aQuad [ 
	| centerCharge |
	centerCharge := 0@0.
	aQuad charge: 0; centerOfCharge: 0@0.
	aQuad isLeaf ifFalse: [
		aQuad subQuadsDo: [ :aSubQuad |
			self accumulate: aSubQuad.
			aQuad charge: aQuad charge + aSubQuad charge.
			centerCharge := centerCharge + (aSubQuad charge * aSubQuad centerOfCharge)] ].

	aQuad soleChild ifNotNil: [ :soleChild |
		| k |
		aQuad isLeaf ifFalse: [
			soleChild translateTo: soleChild position + (random next @ random next) - 0.5 ].
		k := alpha * soleChild charge.
		aQuad charge: aQuad charge + k.
		centerCharge := centerCharge + (k * soleChild position) ].
		
	aQuad charge = 0 ifTrue: [ ^ self ].		
	aQuad centerOfCharge: centerCharge / aQuad charge.		

]

{ #category : #'adding/removing' }
RSForceBasedLayout >> addEdges: realEdges [
	| newMockEdges |
	newMockEdges := realEdges collect: [ :e | self newMockEdgeFor: e ].
	edges class = Array ifTrue: [ edges := OrderedCollection new ].
	edges addAll: newMockEdges.

]

{ #category : #'adding/removing' }
RSForceBasedLayout >> addNodes: realElements [
	| newMockElements |
	newMockElements := (realElements collect: [ :e | self newMockElementFor: e ]).
	nodes class = Array ifTrue: [ nodes := nodes asOrderedCollection ].
	nodes addAll: newMockElements.
	
]

{ #category : #accessing }
RSForceBasedLayout >> alpha [
	^ alpha
]

{ #category : #accessing }
RSForceBasedLayout >> alpha: aFloat [
	"alpha is a value between 0 and 1.
	- 1 represents a strong change in nodes position.
	- 0.01 represents a weak change"
	alpha := aFloat
]

{ #category : #accessing }
RSForceBasedLayout >> center [
	^ center
]

{ #category : #accessing }
RSForceBasedLayout >> center: aPoint [
	"gravity moves elements to that point"
	center := aPoint.
]

{ #category : #accessing }
RSForceBasedLayout >> charge [
	^ charge
]

{ #category : #accessing }
RSForceBasedLayout >> charge: aFloat [
	"Typically a negative value. E.g., -300.
	This value affects new nodes. then you can change charge for each node"
	charge := aFloat
]

{ #category : #accessing }
RSForceBasedLayout >> currentQuadtree [
	^ quadtree
]

{ #category : #hook }
RSForceBasedLayout >> doExecute: nodeShapes [
	nodeShapes do: [ :n | n updateLinesOFF ].
	self nodes: nodeShapes.
	self start.
	self shouldUseProgressBar
		ifTrue: [ self runLayoutInJob ]
		ifFalse: [ self runLayoutSimply ].
	alpha := 0.
	nodes do: [ :e | translator translateTopLeftOf: e to: e position ].
	nodeShapes do: [ :n | n updateLinesON. n connectedLines do: #update ].
]

{ #category : #'public - configuration' }
RSForceBasedLayout >> doNotUseProgressBar [
	shouldUseProgressBar := false
]

{ #category : #accessing }
RSForceBasedLayout >> friction [
	^ friction
]

{ #category : #accessing }
RSForceBasedLayout >> friction: aNumber [
	"usuarly a value between 0 and 1
	This affects all nodes"
	friction := aNumber
]

{ #category : #accessing }
RSForceBasedLayout >> gravity [
	^ gravity
]

{ #category : #accessing }
RSForceBasedLayout >> gravity: aNumber [
	"it is the force from nodes to move around center"
	gravity := aNumber
]

{ #category : #accessing }
RSForceBasedLayout >> initialLayout [
	^ initialLayout
]

{ #category : #accessing }
RSForceBasedLayout >> initialLayout: aLayout [
	"The default layout performed before run this layout"
	initialLayout := aLayout
]

{ #category : #'initialize-release' }
RSForceBasedLayout >> initialize [
	super initialize.
	random := Random new.
	self
		iterations: 0;
		edges: #();
		nodes: #();
		initialLayout: RSGridLayout new;
		gravity: 0.1;
		friction: 0.9;
		theta: 0.8;
		strength: 1;
		length: 20;
		charge: -30;
		center: 0@0;
		useProgressBar.
]

{ #category : #accessing }
RSForceBasedLayout >> iterations: aNumber [
	"aNumber is a 0 positive number used to run this layout aNumber times"
	iterations := aNumber
]

{ #category : #accessing }
RSForceBasedLayout >> length [
	^ length
]

{ #category : #accessing }
RSForceBasedLayout >> length: aFloat [
	"Specifiy the length of the edges. E.g., 50"
	length := aFloat
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockEdgeAt: anEdge [
	^ edges detect: [ :each | each realEdge == anEdge ] ifNone: [ nil ]
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockEdgeAt: anEdge ifPresent: presentBlock [
	^ edges detect: [ :each | each realEdge == anEdge ] ifFound: presentBlock
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockElementAt: realNode [
	^ nodes detect: [ :each | each realElement == realNode ]
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockElementAt: realNode ifPresent: presentBlock [

	^ nodes
		  detect: [ :each | each realElement == realNode ]
		  ifFound: presentBlock
]

{ #category : #'private - initialization' }
RSForceBasedLayout >> newMockEdgeFor: e [
	| from to |
	from := self mockElementAt: e from.
	to := self mockElementAt: e to.
	from addWeight.
	to addWeight.
	^ RSMockEdge new
		from: from;
		to: to;
		strength: strength;
		length: length;
		realEdge: e;
		yourself
]

{ #category : #'private - initialization' }
RSForceBasedLayout >> newMockElementFor: e [
	^ RSMockElement new
		realElement: e;
		charge: charge;
		weight: 0;
		yourself
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> nodes [
	^ nodes
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #'adding/removing' }
RSForceBasedLayout >> removeEdge: aRealEdge [

	self mockEdgeAt: aRealEdge ifPresent: [ :edge | edges remove: edge ]
]

{ #category : #'adding/removing' }
RSForceBasedLayout >> removeNode: aRealNode [
	| node |
	node := self mockElementAt: aRealNode.
	nodes remove: node.
	
]

{ #category : #algorithm }
RSForceBasedLayout >> repulse: aNode from: aQuad [
	
	aQuad soleChild = aNode ifFalse: [
		| d |
		d := aQuad centerOfCharge - aNode position.
		(d closeTo: 0@0) ifFalse: [
			| dn p k |
			dn := 1 / d r.
			p := aNode oldPosition.
			aQuad rectangle width * dn < theta
				ifTrue: [
					k := aQuad charge * dn * dn.
					aNode oldPosition: p - (d * k).
					^ self ].
			(aQuad soleChild notNil and: [ dn < 1e9 ])
				ifTrue: [
					k := aQuad soleChild charge * dn * dn * alpha.
					aNode oldPosition: p - (d * k).] ] ].
 
	(aQuad charge closeTo: 0) ifFalse: [ 
		aQuad subQuadsDo: [ :aSubQuad | self repulse: aNode from: aSubQuad ] ]

]

{ #category : #hook }
RSForceBasedLayout >> runLayoutIn: job [
	iterations isZero ifTrue: [ 
		[alpha := alpha * 0.99.
		alpha > 0.005 ] whileTrue: [ 
			self step.
			job currentValue: 1 - alpha ] ]
	ifFalse: [ 
		iterations timesRepeat: [ 
			alpha := alpha * 0.99.
			self step.
		job currentValue: 1 - alpha ] ]
]

{ #category : #hook }
RSForceBasedLayout >> runLayoutInJob [
	[ :job | 
		job
			title: 'Laying out elements';
			min: 1 - alpha;
			max: 1.
		self runLayoutIn: job ] asJob run
]

{ #category : #hook }
RSForceBasedLayout >> runLayoutSimply [
	iterations = 0 ifTrue: [ 
		[ alpha := alpha * 0.99.
		alpha > 0.005 ] whileTrue: [ self step ] ]
	ifFalse: [ 
		iterations timesRepeat: [ 
			alpha := alpha * 0.99.
			self step ] ]
]

{ #category : #testing }
RSForceBasedLayout >> shouldUseProgressBar [
	^ shouldUseProgressBar
]

{ #category : #hook }
RSForceBasedLayout >> start [
	"mandatory for animations"
	initialLayout on: nodes.
	nodes := nodes collect: [ :node | self newMockElementFor: node ].
	edges := edges collect: [ :e | self newMockEdgeFor: e ].
	alpha :=  0.1.
]

{ #category : #events }
RSForceBasedLayout >> step [
	nodes ifEmpty: [ ^ self ].
	self stepEdgeForces.
	self stepGravityForce.
	self stepNodeRepulsion.
	self stepFriction.
	nodes do: #applyToRealElement
]

{ #category : #events }
RSForceBasedLayout >> stepEdgeForces [
	"Apply forces of edges."
	edges do: [ :each | 
		| from to fp tp len k pd |
		from := each from.
		to := each to.
		fp := from position.
		tp := to position.
		pd := tp - fp.
		len := tp distanceTo: fp.
		(len closeTo: 0) ifFalse: [
			len := alpha * (each strength) * (len - (each length)) / len.
			pd := pd * len.
			k := from weight / (from weight + to weight).
			to translateTo: tp - (pd * k).
			k := 1 - k.
			from translateTo: fp + (pd * k).]
	].

]

{ #category : #events }
RSForceBasedLayout >> stepFriction [
	"Apply friction. This is the last to do in a step, after new positions have been defined."
	nodes do: [ :each | 
		| current new old |
		current := each position.
		old := each oldPosition.

		new := current - ((old - current) * friction).
		each translateTo: new.
		each oldPosition: current ]
]

{ #category : #events }
RSForceBasedLayout >> stepGravityForce [
	"Apply gravity"
	| k |
	k := alpha * gravity.
	(k closeTo: 0) ifTrue: [ ^ self ].
	nodes do: [ :each | 
		| pos |
		pos := each position.
		each translateTo: pos + (k * (center - pos)) ]

]

{ #category : #events }
RSForceBasedLayout >> stepNodeRepulsion [
	"Handle fixed nodes. Do this after all forces in a step were already applied."
	quadtree := RSQuadTreeF withAll: nodes.
	self accumulate: quadtree.
	nodes
		do: [ :each | 
			each isFixed
				ifTrue: [ each translateTo: each fixPosition ]
				ifFalse: [ self repulse: each from: quadtree ] ]
]

{ #category : #accessing }
RSForceBasedLayout >> strength: aFloat [
	"Set the force of attraction for the edges. A high value results in having nodes together.
	The default value is 1.0"
	strength := aFloat
]

{ #category : #accessing }
RSForceBasedLayout >> theta [
	^ theta
]

{ #category : #accessing }
RSForceBasedLayout >> theta: aNumber [
	"Theta coefficient from Barnes-Hut simulation
	- Value ranges on [0, 1]
  	- Performance is better with smaller values
  	- Very small values may not create enough force to give a good result"
	theta := aNumber
]

{ #category : #'public - configuration' }
RSForceBasedLayout >> useProgressBar [
	"Public method. Make the layout use a progress bar"
	shouldUseProgressBar := true
]
