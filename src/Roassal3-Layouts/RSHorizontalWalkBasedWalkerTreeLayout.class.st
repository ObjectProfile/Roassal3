"
Implementation of the Walker algorithm [1] with the fix shown in [2] that makes it run in O(n),
where n is the number of nodes in the hierarchy.

[1]: http://www.cs.unc.edu/techreports/89-034.pdf
[2]: http://dirk.jivas.de/papers/buchheim02improving.pdf
"
Class {
	#name : #RSHorizontalWalkBasedWalkerTreeLayout,
	#superclass : #RSHorizontalWalkBasedTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> addChildSpacing: v [
	"No additional spacing to add."

	
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> ancestor: v_left_i v: v default: defaultAncestor [
	| a |
	a := v_left_i ancestor.
	^ (a isSiblingOf: v)
		ifTrue: [ a ]
		ifFalse: [ defaultAncestor ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> apportion: v ancestor: defaultAncestor [
	| vHasLeftSibling anAncestor i |
	i := v hierarchyIndexInParent.
	anAncestor := defaultAncestor.
	vHasLeftSibling := i > 1.
	vHasLeftSibling
		ifTrue:
			[ | w vSiblings v_left_i v_left_o v_right_i v_right_o s_left_i s_left_o s_right_i s_right_o |
			"First, set siblings."
			vSiblings := v hierarchySiblings.
			w := vSiblings at: i - 1.

			"Second, set running variables."
			v_right_i := v.
			v_right_o := v.
			v_left_i := w.
			v_left_o := vSiblings first.

			"Fourth, set shifts."
			s_right_i := v_right_i mod.
			s_right_o := v_right_o mod.
			s_left_i := v_left_i mod.
			s_left_o := v_left_o mod.
			[ "Do updates eargerly because they are used in the following ifs."
			v_left_i := self nextRight: v_left_i.
			v_right_i := self nextLeft: v_right_i.
			v_left_i isNotNil and: [ v_right_i isNotNil ] ]
				whileTrue: [ | s |
					"Forward output refs and the corresponding descriptors."
					v_left_o := self nextLeft: v_left_o.
					v_right_o := self nextRight: v_right_o.

					"Update the ancestor."
					v_right_o ancestor: v.

					"Compute and apply the shift if positive."
					s := v_left_i prelim - v_right_i prelim + s_left_i - s_right_i
						+ v_right_i height + (self spacing: v_left_i).
					s > 0
						ifTrue: [ | sa |
							sa := self ancestor: v_left_i v: v default: anAncestor.
							self moveSubtree: sa v: v shift: s.
							s_right_i := s_right_i + s.
							s_right_o := s_right_o + s ].

					"Some increments"
					s_left_i := s_left_i + v_left_i mod.
					s_right_i := s_right_i + v_right_i mod.
					s_left_o := s_left_o + v_left_o mod.
					s_right_o := s_right_o + v_right_o mod ].

			"Update the *right* contour."
			(v_left_i isNotNil and: [ (self nextRight: v_right_o) isNil ])
				ifTrue: [ v_right_o
						thread: v_left_i;
						mod: v_right_o mod + s_left_i - s_right_o ].

			"Update the *left* contour, adjust the default ancestor too."
			(v_right_i isNotNil and: [ (self nextLeft: v_left_o) isNil ])
				ifTrue: [ v_left_o
						thread: v_right_i;
						mod: v_left_o mod + s_right_i - s_left_o.
					anAncestor := v ] ].
	^ anAncestor
]

{ #category : #'template message' }
RSHorizontalWalkBasedWalkerTreeLayout >> descriptor [
	^ WalkerItemDescriptor new
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> executeShifts: v [
	| s c |
	s := 0.
	c := 0.
	v hierarchyChildren
		reverseDo: [ :w | 
			w
				prelim: w prelim + s;
				mod: w mod + s.
			c := c + w change.
			s := s + c + w shift ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> firstWalk: v [
	| i |
	"Some useful auxiliaries."
	i := v hierarchyIndexInParent ifNil: [ 1 ].

	"Start with the Walker algorithm."
	v isHierarchyLeaf
		ifTrue: [ | pre |
			"v is the left most sibling"
			pre := i = 1
				ifTrue: [ 0 ]
				ifFalse: [ | w |
					w := v hierarchySiblings at: i - 1.
					w prelim + w height + marginBetweenAdjacentSiblings ].
			v prelim: pre ]
		ifFalse: [ | children midpoint |
			children := v hierarchyChildren.

			"Fold children from left to right, discard the final ancestor because useless from the rest."
			children
				inject: children first
				into: [ :defaultAncestor :w | 
					self
						firstWalk: w;
						apportion: w ancestor: defaultAncestor ].

			"Perform shifts."
			self executeShifts: v.

			"Prepare for the preliminary position of v."
			midpoint := (children first prelim + children last prelim) / 2.

			"v has at least a sibling on its left hand side"
			i > 1
				ifTrue: [ | w |
					w := v hierarchySiblings at: i - 1.
					v prelim: w prelim + w height.
					v mod: v prelim - midpoint ]
				ifFalse: [ v prelim: midpoint ] ]
]

{ #category : #'initialize - release' }
RSHorizontalWalkBasedWalkerTreeLayout >> initDescriptor: aDescriptor [
	aDescriptor
		mod: 0;
		change: 0;
		shift: 0;
		prelim: 0;
		ancestor: aDescriptor;
		thread: nil
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> moveSubtree: w_left v: w_right shift: s [
	| subtrees ratio |
	"Some auxiliary variables."
	subtrees := w_right hierarchyIndexInParent
		- w_left hierarchyIndexInParent.
	ratio := s / subtrees.

	"Updating the left item."
	w_left change: w_left change + ratio.

	"Updating the right item."
	w_right
		change: w_right change - ratio;
		shift: w_right shift + s;
		prelim: w_right prelim + s;
		mod: w_right mod + s
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> nextLeft: v [
	^ v hierarchyChildren
		ifEmpty: [ v thread ]
		ifNotEmpty: [ :children | children first ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> nextRight: v [
	^ v hierarchyChildren
		ifEmpty: [ v thread ]
		ifNotEmpty: [ :children | children last ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> prelimOffsetOfHierarchyItem: v [
	^ 0 @ v prelim
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> secondWalk: v x: n y: m [
	| nNext mNext positionOffset |
	"Some useful auxiliaries."
	nNext := n + v width + marginBetweenAdjacentLayers.
	mNext := m + v mod.

	"Set absolute vertical and horizontal coordinates, depending on the node meter."
	positionOffset := self prelimOffsetOfHierarchyItem: v.
	v position: n @ m + positionOffset.

	"Put additional spacing if needed (by my subclasses perhaps)."
	self addChildSpacing: v.

	"Recur over my onw children."
	v hierarchyChildren
		do:
			[ :hierarchyChild | self secondWalk: hierarchyChild x: nNext y: mNext ]
]
