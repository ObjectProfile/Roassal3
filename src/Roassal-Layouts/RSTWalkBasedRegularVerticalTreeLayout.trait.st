"
This trait defines methods to get information of a roassal shape like the gap, the width and height.
It applies this properties for a vertical tree layout.
Check similarities with `RSTWalkBasedRegularHorizontalTreeLayout`
"
Trait {
	#name : #RSTWalkBasedRegularVerticalTreeLayout,
	#traits : 'RSTGapsHolder',
	#classTraits : 'RSTGapsHolder classTrait',
	#category : #'Roassal-Layouts-Traits'
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
