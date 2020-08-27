"
My users can have edges and nodes useful to build graphs with roassal
"
Trait {
	#name : #RSTContainer,
	#category : #'Roassal3-Core'
}

{ #category : #'adding nodes edges' }
RSTContainer >> add: aShape [
	self
		assert: aShape notNil
		description: 'Nil cannot be added to a canvas'.
	aShape 
		addedIn: self;
		renderOn: self.
	^ aShape
]

{ #category : #'adding nodes edges' }
RSTContainer >> addAll: aCollection [
	"Add a collection of shapes to the canvas
	aCollection of shapes, a shape can be a line or can be a node"
	self assert: [ aCollection isCollection ] description: 'Need to provide a collection as argument'.
	self assert: [ aCollection allSatisfy: [ :e | e isKindOf: RSShape ] ] description: 'Need to provide a collection of RSShape'.
	
	"Add each shape"
	aCollection do: [ :aShape | self add: aShape ]
]

{ #category : #'adding nodes edges' }
RSTContainer >> addEdge: aShape [
	self edges add: aShape.
	^ aShape
]

{ #category : #'adding nodes edges' }
RSTContainer >> addNode: aShape [
	self nodes add: aShape.
	^ aShape
]

{ #category : #accessing }
RSTContainer >> edges [
	"Return all the lines contained in the canvas."
	^ self privateEdges
		ifNil: [ | res |
			self privateEdges: (res := RSGroup new).
			res ]
]

{ #category : #accessing }
RSTContainer >> nodes [ 
	"Return all the shapes except lines contained in the canvas."
	^ self privateNodes
		ifNil: [ | res |
			self privateNodes: (res := RSGroup new).
			res ]
]

{ #category : #accessing }
RSTContainer >> numberOfEdges [
	^ self privateEdges
		ifNil: [ 0 ]
		ifNotNil: [ :edges | edges size ]
]

{ #category : #private }
RSTContainer >> privateEdges [
	^ self explicitRequirement
]

{ #category : #private }
RSTContainer >> privateEdges: aTSGroup [
	self explicitRequirement
]

{ #category : #private }
RSTContainer >> privateNodes [
	^ self explicitRequirement
]

{ #category : #private }
RSTContainer >> privateNodes: aTSGroup [
	self explicitRequirement
]

{ #category : #private }
RSTContainer >> privateShapes [
	^ self explicitRequirement
]

{ #category : #private }
RSTContainer >> privateShapes: aCollection [
	self explicitRequirement
]

{ #category : #removing }
RSTContainer >> removeEdge: anEdge [
	self edges remove: anEdge ifAbsent: [  ].
]

{ #category : #removing }
RSTContainer >> removeNode: aNode [
	self nodes remove: aNode ifAbsent: [  ].
]

{ #category : #accessing }
RSTContainer >> shapeFromModel: anObject [
	"Retreive a shape from a given model. Return nil if not found"

	^ self nodes shapeFromModel: anObject
]

{ #category : #accessing }
RSTContainer >> shapes [ 
	^ self privateShapes
		ifNil: [ | res |
			self privateShapes: (res := RSGroup new).
			res ]
]
