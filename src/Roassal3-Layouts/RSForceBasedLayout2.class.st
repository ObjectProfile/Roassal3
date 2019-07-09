"
I am a layout that uses forces in each elements, I have create a light representation of one element.

"
Class {
	#name : #RSForceBasedLayout2,
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
		'shouldUseProgressBar'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSForceBasedLayout2 >> accumulate: aQuad [ 
	| cx cy k random |
	cx := 0.
	cy := 0.
	
	aQuad charge: 0; cx: 0; cy: 0.
	
	random := Random new.
	
	aQuad isLeaf ifFalse: [ 
		aQuad notNilNodesDo: [ :e | 
			self accumulate: e.
			aQuad charge: aQuad charge + e charge.
			cx := cx + (e charge * e cx).
			cy := cy + (e charge * e cy) ] ].
												
	aQuad node isNil ifFalse: [ 
		aQuad isLeaf ifFalse: [ 
			aQuad node translateTo: aQuad node position + (random next @ random next )- 0.5 ].
		k := alpha * aQuad node charge.
		aQuad charge: aQuad charge + k.
		cx := cx + (k * aQuad node position x). 
		cy := cy + (k * aQuad node position y).].
							
	aQuad charge = 0 ifTrue: [ ^ self ].
	aQuad cx: cx / aQuad charge.
	aQuad cy: cy / aQuad charge.
]

{ #category : #accessing }
RSForceBasedLayout2 >> alpha [
	^ alpha
]

{ #category : #accessing }
RSForceBasedLayout2 >> alpha: aFloat [
	alpha := aFloat
]

{ #category : #accessing }
RSForceBasedLayout2 >> center [
	^ center
]

{ #category : #accessing }
RSForceBasedLayout2 >> center: aPoint [
	"gravity moves elements to that point"
	center := aPoint.
]

{ #category : #accessing }
RSForceBasedLayout2 >> charge [
	^ charge
]

{ #category : #accessing }
RSForceBasedLayout2 >> charge: aFloat [
	"Typically a negative value. E.g., -300"
	charge := aFloat
]

{ #category : #hook }
RSForceBasedLayout2 >> doExecute: nodeElements [
	self nodes: nodeElements.
	self start.
	self shouldUseProgressBar
		ifTrue: [ self runLayoutInJob ]
		ifFalse: [ self runLayoutSimply ].
	alpha := 0.
	nodes do: [ :e | translator translateTopLeftOf: e to: e position ]
]

{ #category : #configuration }
RSForceBasedLayout2 >> doNotUseProgressBar [
	shouldUseProgressBar := false
]

{ #category : #accessing }
RSForceBasedLayout2 >> friction [
	^ friction
]

{ #category : #accessing }
RSForceBasedLayout2 >> friction: aNumber [
	friction := aNumber
]

{ #category : #accessing }
RSForceBasedLayout2 >> gravity [
	^ gravity
]

{ #category : #accessing }
RSForceBasedLayout2 >> gravity: aNumber [
	gravity := aNumber
]

{ #category : #accessing }
RSForceBasedLayout2 >> initialLayout [
	^ initialLayout
]

{ #category : #accessing }
RSForceBasedLayout2 >> initialLayout: aLayout [
	initialLayout := aLayout
]

{ #category : #'initialize-release' }
RSForceBasedLayout2 >> initialize [
	super initialize.
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
RSForceBasedLayout2 >> iterations: aNumber [
	iterations := aNumber
]

{ #category : #accessing }
RSForceBasedLayout2 >> length [
	^ length
]

{ #category : #accessing }
RSForceBasedLayout2 >> length: aFloat [
	"Specifiy the length of the edges. E.g., 50"
	length := aFloat
]

{ #category : #'accessing - model' }
RSForceBasedLayout2 >> mockEdgeAt: anEdge [
	^ edges detect: [ :each | each realEdge == anEdge ]
]

{ #category : #'accessing - model' }
RSForceBasedLayout2 >> mockElementAt: realNode [
	^ nodes detect: [ :each | each realElement == realNode ]
]

{ #category : #'private - initialization' }
RSForceBasedLayout2 >> newMockEdgeFor: e [
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
RSForceBasedLayout2 >> newMockElementFor: e [
	^ RSMockElement new
		realElement: e;
		weight: 0;
		yourself
]

{ #category : #'accessing - model' }
RSForceBasedLayout2 >> nodes [
	^ nodes
]

{ #category : #'accessing - model' }
RSForceBasedLayout2 >> nodes: aCollection [
	nodes := aCollection collect: [ :node | self newMockElementFor: node ].
]

{ #category : #algorithm }
RSForceBasedLayout2 >> repulse: aNode from: aQuad [
	| dx dy |
	dx := aQuad cx - aNode position x.
	dy := aQuad cy - aNode position y.

	((dx closeTo: 0) and: [ dy closeTo: 0 ]) ifFalse: [
		| dn p k |
		dn := 1 / (dx*dx + (dy*dy)) sqrt.
		p := aNode oldPosition.

		aQuad node = aNode ifFalse: [
			(aQuad corner x - aQuad origin x) * dn < theta
				ifTrue: [
					k := aQuad charge * dn * dn.
					aNode oldPosition: p - ((dx @ dy) * k).
					^ self ].
			(aQuad node notNil and: [ dn < 1e9 ])
				ifTrue: [
					k := aQuad node charge * dn * dn * alpha.
					aNode oldPosition: p - ((dx @ dy) * k). ] ] ].

	(aQuad charge closeTo: 0) ifFalse: [ 
		aQuad notNilNodesDo: [ :e | self repulse: aNode from: e ] ]

]

{ #category : #hook }
RSForceBasedLayout2 >> runLayoutInJob [
	[ :job | 
	job
		title: 'Laying out elements';
		min: 1 - alpha;
		max: 1.
	iterations = 0 ifTrue: [ 
		
		[ alpha := alpha * 0.99.
		alpha > 0.005 ] whileTrue: [ 
			self step.
			job currentValue: 1 - alpha ] ]
	ifFalse: [ 
		iterations timesRepeat: [ 
			alpha := alpha * 0.99.
			self step.
		job currentValue: 1 - alpha ] ] ] asJob run
]

{ #category : #hook }
RSForceBasedLayout2 >> runLayoutSimply [
	iterations = 0 ifTrue: [ 
		[ alpha := alpha * 0.99.
		alpha > 0.005 ] whileTrue: [ self step ] ]
	ifFalse: [ 
		iterations timesRepeat: [ 
			alpha := alpha * 0.99.
			self step ] ]
]

{ #category : #testing }
RSForceBasedLayout2 >> shouldUseProgressBar [
	^ shouldUseProgressBar
]

{ #category : #hook }
RSForceBasedLayout2 >> start [
	"mandatory for animations"
	initialLayout on: nodes.
	alpha :=  0.1.
	nodes do: [ :e | e charge ifNil: [ e charge: charge ] ].
	edges := edges collect: [ :e | self newMockEdgeFor: e ].
]

{ #category : #events }
RSForceBasedLayout2 >> step [
	self stepEdgeForces.
	self stepGravityForce.
	self stepNodeRepulsion.
	self stepFriction.
	nodes do: #applyToRealElement
]

{ #category : #events }
RSForceBasedLayout2 >> stepEdgeForces [
	"Apply forces of edges."
	
	edges do: [ :each | 
		| from to fp tp len k pd |
		from := each from.
		to := each to.
		fp := from position.
		tp := to position.
		pd := tp - fp.
		len := tp dist: fp.
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
RSForceBasedLayout2 >> stepFriction [
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
RSForceBasedLayout2 >> stepGravityForce [
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
RSForceBasedLayout2 >> stepNodeRepulsion [
	"Handle fixed nodes. Do this after all forces in a step were already applied."

	| quad |
	quad := RSQuadTree withAll: nodes.
	self accumulate: quad.
	nodes do: [ :each | 
		each isFixed 
			ifTrue: [ each translateTo: each fixPosition ]
			ifFalse: [ self repulse: each from: quad ] ].
]

{ #category : #accessing }
RSForceBasedLayout2 >> strength: aFloat [
	"Set the force of attraction for the edges. A high value results in having nodes together.
	The default value is 1.0"
	strength := aFloat
]

{ #category : #accessing }
RSForceBasedLayout2 >> theta [
	^ theta
]

{ #category : #accessing }
RSForceBasedLayout2 >> theta: aNumber [
	theta := aNumber
]

{ #category : #configuration }
RSForceBasedLayout2 >> useProgressBar [
	shouldUseProgressBar := true
]
