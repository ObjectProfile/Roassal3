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

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> breadthMeasureOf: aShape [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> breakingDepthIndexOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> breakingDepthIndexOf: aNode put: aNumber [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
RSTWalkBasedRegularTreeLayout >> changeOf: aNode update: aBlock [

	^ self changeOf: aNode put: (aBlock value: (self changeOf: aNode))
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> childIndexOf: aShape [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> childIndexOf: aShape put: anInteger [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> childrenOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> childrenOf: aNode put: aValue [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> completedInitializationOf: aNode [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> depthBoundOf: aShape [

	^ (self depthOf: aShape) + (self depthMeasureOf: aShape)
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> depthMeasureOf: aShape [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> depthOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> depthOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> elOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> elOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> erOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> erOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> extremesOfLeaf: aShape [

	self
		elOf: aShape put: aShape;
		erOf: aShape put: aShape;
		mselOf: aShape put: 0;
		mserOf: aShape put: 0
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> extremesOfNonLeaf: parent leftMostChild: leftMostChild rightMostChild: rightMostChild [

	self
		elOf: parent put: (self elOf: leftMostChild);
		erOf: parent put: (self erOf: rightMostChild);
		mselOf: parent put: (self mselOf: leftMostChild);
		mserOf: parent put: (self mserOf: rightMostChild)
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> firstWalk: parent children: children depth: aDepth breadth: aBreadth [

	| leftMostChild bound |
	leftMostChild := children first.

	"Recur down on v's leftmost child."
	self firstWalk: leftMostChild depth: aDepth breadth: aBreadth.

	"Create siblings in contour minimal vertical coordinate and index list."
	bound := self depthBoundOf: (self elOf: leftMostChild).

	(2 to: children size)
		inject: (self updateIYL: bound at: 1 rest: nil)
		into: [ :ih :i | 
			| child |
			child := children at: i.

			self firstWalk: child depth: aDepth breadth: aBreadth.

			bound := self depthBoundOf: (self erOf: child).

			"/Store lowest vertical coordinate while extreme nodes still point in current subtree."
			self
				separate: parent
				children: children
				at: i
				rest: ih.

			"Update data about the widths"
			self updateIYL: bound at: i rest: ih ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> firstWalk: aShape depth: aDepth breadth: aBreadth [

	self
		is: aShape
		ifLeaf: [ self extremesOfLeaf: aShape ]
		ifNotLeaf: [ :children | 
			| leftMostChild rightMostChild |
			leftMostChild := children first.
			rightMostChild := children last.

			self
				firstWalk: aShape
				children: children
				depth: aDepth
				breadth: aBreadth.

			self
				positionNonLeaf: aShape
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild.

			self
				ongoing: aShape
				depth: (self depthOf: aShape) + aDepth
				breadth: (self prelimOf: aShape) + aBreadth.

			self
				extremesOfNonLeaf: aShape
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild ]
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> hasBeenInitializedOf: aNode [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> indexOfIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc key
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayout >> initialize: elements associations: associations ifMultipleRoots: multipleRootsBlock [

	| hierarchy roots allParents rootShape leaves orderedRoots |
	hierarchy := IdentityDictionary new.
	roots := IdentityDictionary new.
	allParents := IdentityDictionary new.
	leaves := IdentitySet new.

	"Mind to loop over elements because they represent the order of incoming data"
	elements do: [ :each |
		leaves add: each.

		roots
			at: each
			ifPresent: [ Warning signal: 'Duplicate shape detected.' ]
			ifAbsentPut: [ roots size + 1 ] ].

	associations
		select: [ :anAssociation | anAssociation key ~~ anAssociation value ]
		thenDo: [ :anAssociation |
			| children child parent multipleParents |
			parent := anAssociation key.
			child := anAssociation value.

			multipleParents := false.
			roots removeKey: child ifAbsent: [ multipleParents := true ].

			"It is okay to try to remove `parent` more than one time because
			two or more associations can share `parent` in the key slot."
			leaves remove: parent ifAbsent: [  ].

			allParents
				at: child
				ifPresent: [ :parents | parents add: parent ]
				ifAbsentPut: [ OrderedCollection with: parent ].

			children := hierarchy
				            at: parent
				            ifAbsentPut: [ OrderedCollection new ].

			self childrenOf: parent put: children.

			multipleParents ifFalse: [
				children add: child.
				self
					childIndexOf: child put: children size;
					siblingsOf: child put: children ] ].

	roots size = 1
		ifTrue: [ rootShape := roots keys anyOne ]
		ifFalse: [
			orderedRoots := roots associations sorted: [ :a :b |
				                a value < b value ].

			orderedRoots := orderedRoots collect: [ :anAssoc |
				                | aRoot |
				                aRoot := anAssoc key.
				                self assert: (allParents includesKey: aRoot) not.
				                aRoot ].

			rootShape := multipleRootsBlock value: orderedRoots.

			self childrenOf: rootShape put: orderedRoots ].
	leaves do: [ :each |
		self
			assert: (self childrenOf: each) isNil;
			initializeShape: each allParents: allParents ].
	^ self initializeShape: rootShape allParents: allParents
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayout >> initialize: elements lines: lines ifMultipleRoots: mrBlocks [

	| associations |
	associations := lines collect: [ :each | each from -> each to ].
	^ self
		  initialize: elements
		  associations: associations
		  ifMultipleRoots: mrBlocks
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayout >> initializeShape: aShape allParents: allParents [

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

	(self childrenOf: aShape) ifNil: [
		self childrenOf: aShape put: #(  ) ].

	depth := allParents
		         at: aShape
		         ifPresent: [ :parents |
			         | level |
			         parents
				         reject: [ :each | self hasBeenInitializedOf: each ]
				         thenDo: [ :each |
				         self initializeShape: each allParents: allParents ].

			         level := (parents collect: [ :each | self levelOf: each ])
				                  max.

			         self levelOf: aShape put: level + 1.

			         parents max: [ :aShapeParent |
				         (self depthBoundOf: aShapeParent)
				         + (self depthGapAmong: aShapeParent and: aShape) ] ]
		         ifAbsent: [ self levelOf: aShape put: 0 ].

	self
		depthOf: aShape put: depth;
		completedInitializationOf: aShape.
	^ aShape
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> is: aShape ifLeaf: lBlock ifNotLeaf: nlBlock [

	^ (self childrenOf: aShape) ifEmpty: lBlock ifNotEmpty: nlBlock
]

{ #category : #API }
RSTWalkBasedRegularTreeLayout >> layout: aRootShape depth: aDepth breadth: aBreadth [

	self
		firstWalk: aRootShape depth: aDepth breadth: aBreadth;
		secondWalk: aRootShape depth: aDepth breadth: aBreadth
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> leftMostChild: leftMostChild currentChild: child child: cl acc: mscl [

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

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> levelOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> levelOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> lowYofIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc value
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> modOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> modOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
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

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
RSTWalkBasedRegularTreeLayout >> mselOf: aNode update: aBlock [

	^ self mselOf: aNode put: (aBlock value: (self mselOf: aNode))
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
RSTWalkBasedRegularTreeLayout >> mserOf: aNode update: aBlock [

	^ self mserOf: aNode put: (aBlock value: (self mserOf: aNode))
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> nextLeftContour: v [

	^ self
		  is: v
		  ifLeaf: [ self threadOf: v ]
		  ifNotLeaf: [ :children | children first ]
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> nextRightContour: v [

	^ self
		  is: v
		  ifLeaf: [ self rthreadOf: v ]
		  ifNotLeaf: [ :children | children last ]
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> ongoing: aShape depth: aDepth breadth: aBreadth [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> positionNonLeaf: parent leftMostChild: leftMostChild rightMostChild: rightMostChild [

	| childrenPrelim |
	"Set the prelim for hierarchy item v."
	childrenPrelim := (self prelimOf: leftMostChild)
	                  + (self modOf: leftMostChild)
	                  + (self prelimOf: rightMostChild)
	                  + (self modOf: rightMostChild)
	                  + (self breadthMeasureOf: rightMostChild)
	                  - (self breadthMeasureOf: parent).
	"	                  + (self breadthMeasureOf: leftMostChild)"

	self prelimOf: parent put: (self prelimOf: leftMostChild).

	self prelimOf: parent put: childrenPrelim / 2
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> positionOf: aShape put: aPoint [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
RSTWalkBasedRegularTreeLayout >> prelimOf: aNode update: aBlock [

	^ self prelimOf: aNode put: (aBlock value: (self prelimOf: aNode))
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> previousChild: previousChild currentChild: currentChild child: sr acc: mssr [

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

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> rthreadOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> rthreadOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #algorithm }
RSTWalkBasedRegularTreeLayout >> secondWalk: aShape depth: n breadth: m [

	| mNext children depth breadth position breakingDepthIndex |
	mNext := m + (self modOf: aShape).

	depth := n + (self depthOf: aShape).
	breadth := (self prelimOf: aShape) + mNext.

	position := self
		            positionOfShape: aShape
		            atDepth: depth
		            atBreadth: breadth.

	self positionOf: aShape put: position.

	self ongoing: aShape depth: depth breadth: breadth.

	children := self childrenOf: aShape.

	self addChildSpacing: children.

	"Recur over my onw children."
	breakingDepthIndex := 0.

	children do: [ :aChild | 
		| childPosition bit |
		childPosition := self secondWalk: aChild depth: n breadth: mNext.

		bit := self
			       updateDepthBreakingIndexOfParent: aShape
			       at: position
			       amongChild: aChild
			       at: childPosition.

		breakingDepthIndex := breakingDepthIndex + bit ].

	self
		breakingDepthIndexOf: aShape
		put: (breakingDepthIndex max: children size - breakingDepthIndex + 1).

	^ position
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
				leftMostChild: children first
				currentChild: (children at: i)
				child: cl
				acc: mscl ]
		ifFalse: [ "the left siblings must be taller than the current subtree."
			(sr isNotNil and: [ cl isNil ]) ifTrue: [ 
				self
					previousChild: (children at: i - 1)
					currentChild: (children at: i)
					child: sr
					acc: mssr ] ]
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #'updating properties' }
RSTWalkBasedRegularTreeLayout >> shiftOf: aNode update: aBlock [

	^ self shiftOf: aNode put: (aBlock value: (self shiftOf: aNode))
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> siblingsOf: aShape [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> siblingsOf: aShape put: aCollection [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> threadOf: aNode [

	self explicitRequirement
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayout >> threadOf: aNode put: aFloat [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayout >> updateDepthBreakingIndexOfParent: aShape at: position amongChild: aChild at: childPosition [

	self explicitRequirement
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
