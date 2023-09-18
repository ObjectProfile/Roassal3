"
This trait provides methods to propagate the vertical gap and horizontal gap
"
Trait {
	#name : #RSTGapsHolder,
	#category : #'Roassal-Layouts-Traits'
}

{ #category : #accessing }
RSTGapsHolder >> horizontalGap [

	self explicitRequirement
]

{ #category : #gap }
RSTGapsHolder >> horizontalGapAmong: aShapeParent and: aShape default: anObject [

	| gap |
	gap := self horizontalGap.

	^ [ gap value: aShapeParent value: aShape value: anObject ]
		  onDNU: #value:value:value:
		  do: [ gap ]
]

{ #category : #accessing }
RSTGapsHolder >> verticalGap [

	self explicitRequirement
]

{ #category : #gap }
RSTGapsHolder >> verticalGapAmong: aShapeParent and: aShape default: anObject [

	| gap |
	gap := self verticalGap.

	^ [ gap value: aShapeParent value: aShape value: anObject ]
		  onDNU: #value:value:value:
		  do: [ gap ]
]
