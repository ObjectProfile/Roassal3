"
I adds utility methods to access meta information of the layout algorithm and I store that information the the shape properties dictionary
"
Trait {
	#name : #RSTWalkBasedRegularTreeLayoutOnShapeProperties,
	#category : #'Roassal-Layouts-Traits'
}

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> changeOf: aNode [

	^ aNode propertyAt: #change
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> changeOf: aNode put: aFloat [

	^ aNode propertyAt: #change put: aFloat
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
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> threadOf: aNode [

	^ aNode propertyAt: #thread
]

{ #category : #properties }
RSTWalkBasedRegularTreeLayoutOnShapeProperties >> threadOf: aNode put: aFloat [

	^ aNode propertyAt: #thread put: aFloat
]
