"
My users can have edges and nodes useful to build graphs with roassal
"
Trait {
	#name : #TContainer,
	#category : #'Roassal3-Core'
}

{ #category : #'adding nodes edges' }
TContainer >> add: aShape [
	self
		assert: aShape notNil
		description: 'Nil cannot be added to a canvas'.
	aShape 
		renderOn: self;
		addedIn: self.
	^ aShape
]

{ #category : #'adding nodes edges' }
TContainer >> addAll: aCollection [
	"Add a collection of shapes to the canvas
	aCollection of shapes, a shape can be a line or can be a node"
	self assert: [ aCollection isCollection ] description: 'Need to provide a collection as argument'.
	self assert: [ aCollection allSatisfy: [ :e | e isKindOf: RSShape ] ] description: 'Need to provide a collection of RSShape'.
	
	"Add each shape"
	aCollection do: [ :aShape | self add: aShape ]
]

{ #category : #'adding nodes edges' }
TContainer >> addEdge: aShape [
	self edges add: aShape.
	^ aShape
]

{ #category : #'adding nodes edges' }
TContainer >> addNode: aShape [
	self nodes add: aShape.
	^ aShape
]

{ #category : #accessing }
TContainer >> edges [
	^ self privateEdges
		ifNil: [ | res |
			self privateEdges: (res := RSGroup new).
			res ]
]

{ #category : #accessing }
TContainer >> nodes [ 
	^ self privateNodes
		ifNil: [ | res |
			self privateNodes: (res := RSGroup new).
			res ]
]

{ #category : #accessing }
TContainer >> numberOfEdges [
	^ self privateEdges
		ifNil: [ 0 ]
		ifNotNil: [ :edges | edges size ]
]

{ #category : #private }
TContainer >> privateEdges [
	^ self explicitRequirement
]

{ #category : #private }
TContainer >> privateEdges: aTSGroup [
	self explicitRequirement
]

{ #category : #private }
TContainer >> privateNodes [
	^ self explicitRequirement
]

{ #category : #private }
TContainer >> privateNodes: aTSGroup [
	self explicitRequirement
]

{ #category : #private }
TContainer >> privateShapes [
	^ self explicitRequirement
]

{ #category : #private }
TContainer >> privateShapes: aCollection [
	self explicitRequirement
]

{ #category : #accessing }
TContainer >> shapeFromModel: anObject [
	^ self nodes shapeFromModel: anObject
]

{ #category : #accessing }
TContainer >> shapes [ 
	^ self privateShapes
		ifNil: [ | res |
			self privateShapes: (res := RSGroup new).
			res ]
]
