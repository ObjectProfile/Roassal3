Trait {
	#name : #RSTWalkBasedRegularTreeLayoutOnShapeProperties,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> breakingDepthIndexOf: aShape [

	^ aShape propertyAt: #breakingDepthIndex
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> breakingDepthIndexOf: aShape put: aNumber [

	^ aShape propertyAt: #breakingDepthIndex put: aNumber
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> changeOf: aNode [

	^ aNode propertyAt: #change
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> changeOf: aNode put: aFloat [

	^ aNode propertyAt: #change put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> childIndexOf: aShape [

	^ aShape propertyAt: #childIndex
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> childIndexOf: aShape put: anInteger [

	^ aShape propertyAt: #childIndex put: anInteger
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> childrenOf: aNode [

	^ aNode propertyAt: #children
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> childrenOf: aNode put: aValue [

	^ aNode propertyAt: #children put: aValue
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> completedInitializationOf: aNode [

	^ aNode propertyAt: #vdpInitialized put: true
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> depthOf: aNode [

	^ aNode propertyAt: #depth
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> depthOf: aNode put: aFloat [

	^ aNode propertyAt: #depth put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> elOf: aNode [

	^ aNode propertyAt: #el
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> elOf: aNode put: aFloat [

	^ aNode propertyAt: #el put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> erOf: aNode [

	^ aNode propertyAt: #er
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> erOf: aNode put: aFloat [

	^ aNode propertyAt: #er put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> hasBeenInitializedOf: aNode [

	^ aNode propertyAt: #vdpInitialized ifAbsent: [ false ]
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> levelOf: aNode [

	^ aNode propertyAt: #vdpLevel
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> levelOf: aNode put: aFloat [

	^ aNode propertyAt: #vdpLevel put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> modOf: aNode [

	^ aNode propertyAt: #mod
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> modOf: aNode put: aFloat [

	^ aNode propertyAt: #mod put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> mselOf: aNode [

	^ aNode propertyAt: #msel
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> mselOf: aNode put: aFloat [

	^ aNode propertyAt: #msel put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> mserOf: aNode [

	^ aNode propertyAt: #mser
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> mserOf: aNode put: aFloat [

	^ aNode propertyAt: #mser put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> positionOf: aShape put: aPoint [

	^ aShape position: aPoint
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> prelimOf: aNode [

	^ aNode propertyAt: #prelim
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> prelimOf: aNode put: aFloat [

	^ aNode propertyAt: #prelim put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> rthreadOf: aNode [

	^ aNode propertyAt: #rthread
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> rthreadOf: aNode put: aFloat [

	^ aNode propertyAt: #rthread put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> shiftOf: aNode [

	^ aNode propertyAt: #shift
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> shiftOf: aNode put: aFloat [

	^ aNode propertyAt: #shift put: aFloat
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> siblingsOf: aShape [

	^ aShape propertyAt: #siblings
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> siblingsOf: aShape put: aCollection [

	^ aShape propertyAt: #siblings put: aCollection
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> threadOf: aNode [

	^ aNode propertyAt: #thread
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> threadOf: aNode put: aFloat [

	^ aNode propertyAt: #thread put: aFloat
]
