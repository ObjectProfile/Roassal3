"
I am a layout that uses forces in each elements, I have create a light representation of one element.
On a given graph or network. It uses the force-directed layout approach to position the nodes
The class provides methods to configure the layout parameters, such as the force constants,

The force-based layout algorithm works by simulating a physical system, where nodes are
treated as particles that repel each other due to electrical charges and are attracted
to each other by springs. By iteratively applying these forces, the algorithm moves the
nodes towards an equilibrium state, resulting in an aesthetically pleasing layout.
The RSForceBasedLayout class provides a flexible and efficient implementation of the
force-directed layout algorithm, allowing users to apply it to a variety of graph structures.

# Collaborators
I work with `RSMockShape` and `RSMockLine`. I work for optimization I work with `RSQuadTreeForce`

"
Class {
	#name : #RSForceBasedLayout,
	#superclass : #RSLineDrivenLayout,
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
		'quadtree',
		'autoRepulse'
	],
	#category : #'Roassal3-Layouts-Force'
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
	aQuad centerOfCharge: centerCharge / aQuad charge
]

{ #category : #'adding-removing' }
RSForceBasedLayout >> addLines: realLines [
	| newMockLines |
	newMockLines := realLines
		collect: [ :e | self newMockLineFor: e ]
		thenReject: [:e | e isNil ].
	lines class = Array ifTrue: [ lines := OrderedCollection new ].
	lines addAll: newMockLines
]

{ #category : #'adding-removing' }
RSForceBasedLayout >> addNodes: realElements [
	| newMockElements |
	newMockElements := (realElements collect: [ :e | self newMockElementFor: e ]).
	nodes class = Array ifTrue: [ nodes := nodes asOrderedCollection ].
	nodes addAll: newMockElements
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
RSForceBasedLayout >> autoRepulse [
	^ autoRepulse
]

{ #category : #accessing }
RSForceBasedLayout >> autoRepulse: aBoolean [
	autoRepulse := aBoolean
]

{ #category : #hook }
RSForceBasedLayout >> calculateAutoRepulse [
	lines do: [ :line | self calculateAutoRepulseFor: line ].
	nodes do: [ :node | | e |
		e := node extent.
		e := e x max: e y.
		node charge: e * -2 ]
]

{ #category : #hook }
RSForceBasedLayout >> calculateAutoRepulseFor: line [
	| e1 e2 n |
	e1 := line from extent.
	e2 := line to extent.
	e1 := e1 x max: e1 y.
	e2 := e2 x max: e2 y.
	n := (e1 + e2) * 0.7.
	line length: n
]

{ #category : #accessing }
RSForceBasedLayout >> center [
	^ center
]

{ #category : #accessing }
RSForceBasedLayout >> center: aPoint [
	"gravity moves elements to that point"
	center := aPoint
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
	alpha := nil.
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

{ #category : #initialization }
RSForceBasedLayout >> initialize [
	super initialize.
	random := Random seed: 42.
	self reset.
]

{ #category : #accessing }
RSForceBasedLayout >> iterations [
	^ iterations
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
RSForceBasedLayout >> mockElementAt: realNode [
	^ nodes detect: [ :each | each realShape == realNode ] ifNone: [ nil ]
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockElementAt: realNode ifPresent: presentBlock [

	^ nodes
		  detect: [ :each | each realShape == realNode ]
		  ifFound: presentBlock
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockLineAt: anEdge [
	^ lines detect: [ :each | each realLine == anEdge ] ifNone: [ nil ]
]

{ #category : #'accessing - model' }
RSForceBasedLayout >> mockLineAt: anEdge ifPresent: presentBlock [
	^ lines detect: [ :each | each realLine == anEdge ] ifFound: presentBlock
]

{ #category : #'private - initialization' }
RSForceBasedLayout >> newMockElementFor: e [
	^ RSMockShape new
		realShape: e;
		charge: charge;
		weight: 0;
		yourself
]

{ #category : #'private - initialization' }
RSForceBasedLayout >> newMockLineFor: e [
	| from to |
	from := self mockElementAt: e from.
	to := self mockElementAt: e to.
	(from isNil or: [to isNil]) ifTrue: [ ^ nil ].
	from addWeight.
	to addWeight.
	^ RSMockLine new
		from: from;
		to: to;
		strength: strength;
		length: length;
		realLine: e;
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

{ #category : #'adding-removing' }
RSForceBasedLayout >> removeEdge: aRealEdge [

	self mockLineAt: aRealEdge ifPresent: [ :edge | lines remove: edge ]
]

{ #category : #'adding-removing' }
RSForceBasedLayout >> removeNode: aRealNode [
	| node |
	node := self mockElementAt: aRealNode.
	nodes remove: node
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

{ #category : #initialization }
RSForceBasedLayout >> reset [
	self
		autoRepulse: false;
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
		useProgressBar
]

{ #category : #hook }
RSForceBasedLayout >> runLayoutIn: job [
	"Central method"
	iterations isZero ifTrue: [
		[alpha := alpha * 0.99.
		alpha > 0.005 ] whileTrue: [
			self step.
			job currentValue: 1 - alpha ] ]
	ifFalse: [
		iterations timesRepeat: [
			alpha := alpha * 0.99.
			self step.
		job currentValue: 1 - alpha ] ].
	self nodes: #(); edges: #().
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
	self runLayoutIn: Job new
]

{ #category : #testing }
RSForceBasedLayout >> shouldUseProgressBar [
	^ shouldUseProgressBar
]

{ #category : #testing }
RSForceBasedLayout >> shouldUseProgressBar: aBoolean [
	shouldUseProgressBar := aBoolean
]

{ #category : #hook }
RSForceBasedLayout >> start [
	"mandatory for animations"
	initialLayout on: nodes.
	nodes := nodes collect: [ :node | self newMockElementFor: node ].
	lines := lines
		collect: [ :e | self newMockLineFor: e ]
		thenReject: [:e | e isNil ].
	self autoRepulse ifTrue: [
		self calculateAutoRepulse.
		 ].
	alpha ifNil: [ alpha :=  0.1 ]
]

{ #category : #hook }
RSForceBasedLayout >> step [
	nodes ifEmpty: [ ^ self ].
	self stepEdgeForces.
	self stepGravityForce.
	self stepNodeRepulsion.
	self stepFriction.
	nodes do: [ :node | node applyToRealElement ]
]

{ #category : #events }
RSForceBasedLayout >> stepEdgeForces [
	"Apply forces of edges."
	lines do: [ :each |
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
	]
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
	quadtree := RSQuadTreeForce withAll: nodes.
	self accumulate: quadtree.
	nodes
		do: [ :each |
			each isFixed
				ifTrue: [ each translateTo: each fixPosition ]
				ifFalse: [ self repulse: each from: quadtree ] ]
]

{ #category : #accessing }
RSForceBasedLayout >> strength [
	^ strength
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
