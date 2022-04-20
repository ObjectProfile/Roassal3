Trait {
	#name : #RSTWalkBasedRegularHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	^ self verticalGapAmong: aShapeParent and: aShape
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape height
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	^ self horizontalGapAmongParent: aShapeParent andChild: aShape
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> depthMeasureOf: aShape [

	^ aShape width
]

{ #category : #accessing }
RSTWalkBasedRegularHorizontalTreeLayout >> horizontalGapAmongParent: aShapeParent andChild: aShape [

	self explicitRequirement
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	| shift |
	shift := aShape extent / 2.
	^ depth @ breadth + shift
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> updateDepthBreakingIndexOfParent: aShape at: position amongChild: aChild at: childPosition [

	^ (position y > childPosition y) asBit
]

{ #category : #accessing }
RSTWalkBasedRegularHorizontalTreeLayout >> verticalGapAmong: aShapeParent and: aShape [

	self explicitRequirement
]
