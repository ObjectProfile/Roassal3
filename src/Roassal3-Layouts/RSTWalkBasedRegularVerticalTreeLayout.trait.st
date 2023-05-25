"
Used in WalkbasedRegularVerticalTreeLayout
"
Trait {
	#name : #RSTWalkBasedRegularVerticalTreeLayout,
	#traits : 'RSTGapsHolder',
	#classTraits : 'RSTGapsHolder classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	^ self
		  horizontalGapAmong: aShapeParent
		  and: aShape
		  default: RSAbstractGraphLayout horizontalGap
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape width
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	^ self
		  verticalGapAmong: aShapeParent
		  and: aShape
		  default: RSAbstractGraphLayout verticalGap
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> depthMeasureOf: aShape [

	^ aShape height
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	| shift |
	shift := aShape extent / 2.
	^ breadth @ depth + shift
]
