"
I am the tree layout algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

I encode the main algorithm leaving objects that use my behavior to fullfil some explicit requirements concerning the dimension the tree will grow toward to.

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Trait {
	#name : #RSTWalkBasedRegularTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> addChildSpacing: children [

	^ children inject: 0 @ 0 into: [ :aPoint :child | 
		  | x newPoint y |
		  x := aPoint x + (self shiftOf: child).
		  y := x + aPoint y + (self changeOf: child).
		  newPoint := Point x: x y: y.
		  self modOf: child update: [ :mod | mod + newPoint y ].
		  newPoint ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> breadthMeasureOf: aShape [

	self explicitRequirement
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode [

	^ aNode propertyAt: #change
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode put: aFloat [

	^ aNode propertyAt: #change put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode update: aBlock [

	^ self changeOf: aNode put: (aBlock value: (self changeOf: aNode))
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> childrenOf: aNode [

	^ aNode propertyAt: #children
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> childrenOf: aNode put: aValue [

	^ aNode propertyAt: #children put: aValue
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> depthBoundOf: aShape [

	^ (self depthOf: aShape) + (self depthMeasureOf: aShape)
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> depthMeasureOf: aShape [

	self explicitRequirement
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> depthOf: aNode [

	^ aNode propertyAt: #depth
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> depthOf: aNode put: aFloat [

	^ aNode propertyAt: #depth put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> elOf: aNode [

	^ aNode propertyAt: #el
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> elOf: aNode put: aFloat [

	^ aNode propertyAt: #el put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> erOf: aNode [

	^ aNode propertyAt: #er
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> erOf: aNode put: aFloat [

	^ aNode propertyAt: #er put: aFloat
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> firstWalk: v [

	self
		is: v
		ifLeaf: [ self setExtremesOfLeaf: v ]
		ifNotLeaf: [ :children | 
			| leftMostChild rightMostChild chain bound |
			leftMostChild := children first.
			rightMostChild := children last.

			"Recur down on v's leftmost child."
			self firstWalk: leftMostChild.

			"Create siblings in contour minimal vertical coordinate and index list."
			bound := self depthBoundOf: (self elOf: leftMostChild).

			chain := (2 to: children size)
				         inject: (self updateIYL: bound at: 1 rest: nil)
				         into: [ :ih :i | 
					         | child |
					         child := children at: i.

					         self firstWalk: child.

					         bound := self depthBoundOf: (self erOf: child).

					         "/Store lowest vertical coordinate while extreme nodes still point in current subtree."
					         self
						         separate: v
						         children: children
						         at: i
						         rest: ih.

					         "Update data about the widths"
					         self updateIYL: bound at: i rest: ih ].

			self
				positionRoot: v
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild.

			self
				setExtremesOfNonLeaf: v
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> indexOfIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc key
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayout >> initialize: elements edges: edges [

	| hierarchy roots fathers root level |
	hierarchy := IdentityDictionary new.
	roots := IdentitySet withAll: elements.
	fathers := IdentityDictionary new.

	edges do: [ :anEdge | 
		| children child father multipleParents |
		father := anEdge from.
		child := anEdge to.

		multipleParents := false.
		roots remove: child ifAbsent: [ multipleParents := true ].

		multipleParents ifFalse: [ 
			fathers at: child put: father.

			children := hierarchy
				            at: father
				            ifAbsentPut: [ 
				            self childrenOf: father put: OrderedCollection new ].

			children add: child ] ].

	root := roots size > 1
		        ifTrue: [ 
			        | children rootBox |
			        level := -1.
			        rootBox := RSBox new.
			        children := self
				                    childrenOf: rootBox
				                    put: OrderedCollection new.

			        roots do: [ :each | 
				        self assert: (fathers includesKey: each) not.
				        children add: each
				        "fathers at: each put: rootBox" ].

			        rootBox ]
		        ifFalse: [ 
			        level := 0.
			        roots anyOne ].

	self initializeForShape: root atLevel: level fathers: fathers.

	^ root
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayout >> initializeForShape: aShape atLevel: aLevel fathers: fathers [

	| depth |
	self
		modOf: aShape put: 0;
		changeOf: aShape put: 0;
		shiftOf: aShape put: 0;
		prelimOf: aShape put: 0;
		mselOf: aShape put: 0;
		mserOf: aShape put: 0;
		threadOf: aShape put: nil;
		rthreadOf: aShape put: nil;
		elOf: aShape put: nil;
		erOf: aShape put: nil.

	depth := fathers
		         at: aShape
		         ifPresent: [ :aShapeParent | 
			         (self depthBoundOf: aShapeParent)
			         + (self depthGapAmong: aShapeParent and: aShape) ]
		         ifAbsent: [ 0 ].

	self depthOf: aShape put: depth.

	(self childrenOf: aShape)
		ifNil: [ self childrenOf: aShape put: OrderedCollection new ]
		ifNotNil: [ :children | 
			children do: [ :each | 
				self initializeForShape: each atLevel: aLevel + 1 fathers: fathers ] ]
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> is: aShape ifLeaf: lBlock ifNotLeaf: nlBlock [

	^ (self childrenOf: aShape) ifEmpty: lBlock ifNotEmpty: nlBlock
]

{ #category : #API }
RSTWalkBasedRegularTreeLayout >> layout: aRootShape atPoint: aPoint [

	self
		firstWalk: aRootShape;
		secondWalk: aRootShape depth: aPoint x breadth: aPoint y
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> lowYofIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc value
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> modOf: aNode [

	^ aNode propertyAt: #mod
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> modOf: aNode put: aFloat [

	^ aNode propertyAt: #mod put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> modOf: aNode update: aBlock [

	^ self modOf: aNode put: (aBlock value: (self modOf: aNode))
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> moveSubtree: children at: i other: si distance: dist [

	"Move subtree by changing mod."

	| child intermediateChildren |
	child := children at: i.

	self
		modOf: child update: [ :mod | mod + dist ];
		mselOf: child update: [ :msel | msel + dist ];
		mserOf: child update: [ :mser | mser + dist ].

	"Are there intermediate children? (originally extracted in the `distributedExtra` function)"
	self assert: i > si.

	(intermediateChildren := i - si) > 1 ifTrue: [ 
		| siChild ratio |
		ratio := dist / intermediateChildren.
		siChild := children at: si + 1.
		self
			shiftOf: siChild update: [ :shift | shift + ratio ];
			shiftOf: child update: [ :shift | shift - ratio ];
			changeOf: child update: [ :change | change - dist + ratio ] ]
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode [

	^ aNode propertyAt: #msel
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode put: aFloat [

	aNode propertyAt: #msel put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode update: aBlock [

	^ self mselOf: aNode put: (aBlock value: (self mselOf: aNode))
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode [

	^ aNode propertyAt: #mser
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode put: aFloat [

	aNode propertyAt: #mser put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode update: aBlock [

	^ self mserOf: aNode put: (aBlock value: (self mserOf: aNode))
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> nextLeftContour: v [

	^ self
		  is: v
		  ifLeaf: [ self threadOf: v ]
		  ifNotLeaf: [ (self childrenOf: v) first ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> nextRightContour: v [

	^ self
		  is: v
		  ifLeaf: [ self rthreadOf: v ]
		  ifNotLeaf: [ (self childrenOf: v) last ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> positionRoot: v leftMostChild: leftMostChild rightMostChild: rightMostChild [

	| childrenPrelim |
	"Set the prelim for hierarchy item v."
	childrenPrelim := (self prelimOf: leftMostChild)
	                  + (self modOf: leftMostChild)
	                  + (self prelimOf: rightMostChild)
	                  + (self modOf: rightMostChild)
	                  + (self breadthMeasureOf: rightMostChild)
	                  - (self breadthMeasureOf: v).

	self prelimOf: v put: childrenPrelim / 2
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode [

	^ aNode propertyAt: #prelim
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode put: aFloat [

	^ aNode propertyAt: #prelim put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode update: aBlock [

	^ self prelimOf: aNode put: (aBlock value: (self prelimOf: aNode))
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> rthreadOf: aNode [

	^ aNode propertyAt: #rthread
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> rthreadOf: aNode put: aFloat [

	aNode propertyAt: #rthread put: aFloat
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> secondWalk: aShape depth: n breadth: m [

	| mNext children depth breadth |
	mNext := m + (self modOf: aShape).

	depth := n + (self depthOf: aShape).
	breadth := (self prelimOf: aShape) + mNext.

	aShape position:
		(self positionOfShape: aShape atDepth: depth atBreadth: breadth)
		+ (aShape extent / 2).

	children := self childrenOf: aShape.

	self addChildSpacing: children.

	"Recur over my onw children."
	children do: [ :aChild | 
		self secondWalk: aChild depth: n breadth: mNext ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> separate: v children: children at: i rest: aValueLink [

	| sr cl mssr mscl ih |
	"Right contour node of left siblings and its sum of modfiers."
	sr := children at: i - 1.
	mssr := self modOf: sr.

	"Left contour node of current subtree and its sum of modfiers."
	cl := children at: i.
	mscl := self modOf: cl.

	"Looping"
	ih := aValueLink.
	[ sr isNotNil and: [ cl isNotNil ] ] whileTrue: [ 
		| dist sy cy |
		(self depthBoundOf: sr) > (self lowYofIYL: ih) ifTrue: [ 
			ih := ih nextLink ].

		"How far to the left of the right side of sr is the left side of cl?"
		dist := mssr + (self prelimOf: sr) + (self breadthMeasureOf: sr)
		        + (self breadthGapAmong: sr and: cl) - mscl
		        - (self prelimOf: cl).

		dist > 0 ifTrue: [ 
			mscl := mscl + dist.
			self
				moveSubtree: children
				at: i
				other: (self indexOfIYL: ih)
				distance: dist ].

		"Advance highest node(s) and sum(s) of modifiers (Coordinate system increases downwards)"
		sy := self depthBoundOf: sr.
		cy := self depthBoundOf: cl.

		sy <= cy ifTrue: [ 
			sr := self nextRightContour: sr.
			sr ifNotNil: [ mssr := mssr + (self modOf: sr) ] ].

		sy >= cy ifTrue: [ 
			cl := self nextLeftContour: cl.
			cl ifNotNil: [ mscl := mscl + (self modOf: cl) ] ] ].

	"Set threads and update extreme nodes."
	(sr isNil and: [ cl isNotNil ])
		ifTrue: [ "the current subtree must be taller than the left siblings."
			self
				setLeftThread: v
				leftMostChild: children first
				currentChild: (children at: i)
				child: cl
				acc: mscl ]
		ifFalse: [ "the left siblings must be taller than the current subtree."
			(sr isNotNil and: [ cl isNil ]) ifTrue: [ 
				self
					setRightThread: v
					previousChild: (children at: i - 1)
					currentChild: (children at: i)
					child: sr
					acc: mssr ] ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> setExtremesOfLeaf: v [

	self
		elOf: v put: v;
		erOf: v put: v;
		mselOf: v put: 0;
		mserOf: v put: 0
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> setExtremesOfNonLeaf: v leftMostChild: leftMostChild rightMostChild: rightMostChild [

	self
		elOf: v put: (self elOf: leftMostChild);
		erOf: v put: (self erOf: rightMostChild);
		mselOf: v put: (self mselOf: leftMostChild);
		mserOf: v put: (self mserOf: rightMostChild)
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> setLeftThread: v leftMostChild: leftMostChild currentChild: child child: cl acc: mscl [

	| li diff |
	li := self elOf: leftMostChild.
	self threadOf: li put: cl.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mscl - (self modOf: cl) - (self mselOf: leftMostChild).
	self modOf: li update: [ :mod | mod + diff ].

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: li update: [ :prelim | prelim - diff ].

	"Update extreme node and its sum of modifiers."
	self
		elOf: leftMostChild put: (self elOf: child);
		mselOf: leftMostChild put: (self mselOf: child)
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> setRightThread: v previousChild: previousChild currentChild: currentChild child: sr acc: mssr [

	| ri diff |
	ri := self erOf: currentChild.
	self rthreadOf: ri put: sr.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mssr - (self modOf: sr) - (self mserOf: currentChild).
	self modOf: ri update: [ :mod | mod + diff ].

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: ri update: [ :prelim | prelim - diff ].

	"Update extreme node and its sum of modifiers."
	self
		erOf: currentChild put: (self erOf: previousChild);
		mserOf: currentChild put: (self mserOf: previousChild)
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode [

	^ aNode propertyAt: #shift
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode put: aFloat [

	aNode propertyAt: #shift put: aFloat
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode update: aBlock [

	^ self shiftOf: aNode put: (aBlock value: (self shiftOf: aNode))
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> threadOf: aNode [

	^ aNode propertyAt: #thread
]

{ #category : #'layout-properties' }
RSTWalkBasedRegularTreeLayout >> threadOf: aNode put: aFloat [

	aNode propertyAt: #thread put: aFloat
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> updateIYL: minY at: i rest: aValueLink [

	| ih |
	"Remove siblings that are hidden by the new subtree."
	ih := aValueLink.
	[ ih isNotNil and: [ minY >= (self lowYofIYL: ih) ] ] whileTrue: [ 
		ih := ih nextLink ].

	"Prepend the new subtree"
	^ ValueLink new
		  value: i -> minY;
		  nextLink: ih;
		  yourself
]
