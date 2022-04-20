Trait {
	#name : #RSTWalkBasedRegularVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthGapAmong: aShape and: anotherShape [

	^ self horizontalGapAmong: aShape and: anotherShape
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape width
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	^ self verticalGapAmongParent: aShapeParent andChild: aShape
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> depthMeasureOf: aShape [

	^ aShape height
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> horizontalGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	| shift |
	shift := aShape extent / 2.

	^ breadth @ depth + shift
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> updateDepthBreakingIndexOfParent: aShape at: position amongChild: aChild at: childPosition [

	^ (position x > childPosition x) asBit
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> verticalGapAmongParent: aShapeParent andChild: aShape [

	self explicitRequirement
]
