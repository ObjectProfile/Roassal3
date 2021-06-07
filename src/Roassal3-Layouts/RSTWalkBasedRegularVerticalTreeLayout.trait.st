Trait {
	#name : #RSTWalkBasedRegularVerticalTreeLayout,
	#traits : 'RSTGapsHolder',
	#classTraits : 'RSTGapsHolder classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	| gap |
	gap := self horizontalGap.
	
	^ [ gap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ gap ]
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> breadthMeasureOf: aShape [

	^ aShape width
]

{ #category : #positioning }
RSTWalkBasedRegularVerticalTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	| gap |
	gap := self verticalGap.

	^ [ gap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ gap ]
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
