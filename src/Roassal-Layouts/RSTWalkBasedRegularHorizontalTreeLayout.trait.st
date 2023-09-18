"
This trait defines methods to get information of a roassal shape like the gap, the width and height.
It applies this properties for a horizontal tree layout.
Check similarities with `RSTWalkBasedRegularVerticalTreeLayout`
"
Trait {
	#name : #RSTWalkBasedRegularHorizontalTreeLayout,
	#traits : 'RSTGapsHolder',
	#classTraits : 'RSTGapsHolder classTrait',
	#category : #'Roassal-Layouts-Traits'
}

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	^ self
		  verticalGapAmong: aShapeParent
		  and: aShape
		  default: RSAbstractGraphLayout horizontalGap
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape height
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	^ self
		  horizontalGapAmong: aShapeParent
		  and: aShape
		  default: RSAbstractGraphLayout verticalGap
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> depthMeasureOf: aShape [

	^ aShape width
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	| shift |
	shift := aShape extent / 2.
	^ depth @ breadth + shift
]
