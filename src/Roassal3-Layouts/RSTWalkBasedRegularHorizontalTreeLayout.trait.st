Trait {
	#name : #RSTWalkBasedRegularHorizontalTreeLayout,
	#traits : 'RSTGapsHolder',
	#classTraits : 'RSTGapsHolder classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	| gap |
	gap := self verticalGap.

	^ [ gap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ gap ]
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape height
]

{ #category : #positioning }
RSTWalkBasedRegularHorizontalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	| gap |
	gap := self horizontalGap.
	
	^ [ gap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ gap ]
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
