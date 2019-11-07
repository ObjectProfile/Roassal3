"
I represent lines models in RSView
"
Class {
	#name : #RSEdge,
	#superclass : #RSShapedObject,
	#instVars : [
		'from',
		'to',
		'attachPoint',
		'controlPoints'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #'instance creation' }
RSEdge class >> from: anElement1 to: anElement2 [
	^ self new 
		from: anElement1;
		to: anElement2;
		yourself
]

{ #category : #adding }
RSEdge >> addedIn: aParent [
	aParent addEdge: self.
	self announceAdded: RSEdgeAdded parent: aParent
]

{ #category : #accessing }
RSEdge >> attachPoint [
	^ attachPoint
]

{ #category : #accessing }
RSEdge >> attachPoint: ap [
	attachPoint := ap.
]

{ #category : #accessing }
RSEdge >> controlPoints [ 
	^ controlPoints
]

{ #category : #accessing }
RSEdge >> controlPoints: aCollection [
	controlPoints := aCollection.
	aCollection isCollection ifFalse: [ ^ self ].
	controlPoints do: [ :cp | 
		self setAnchor: nil element: cp ].
]

{ #category : #accessing }
RSEdge >> from [
	^ from
]

{ #category : #accessing }
RSEdge >> from: aShape [
	from := self setAnchor: from shape: aShape.
]

{ #category : #initialization }
RSEdge >> initialize [
	super initialize.
	attachPoint := RSCenteredAttachPoint new.
]

{ #category : #testing }
RSEdge >> isEdge [
	^ true
]

{ #category : #removing }
RSEdge >> remove [
	parent ifNil: [ ^ self ].
	parent removeEdge: self.
	self 
		removeFromParent: to;
		removeFromParent: from.
	parent := nil.
]

{ #category : #removing }
RSEdge >> removeFromParent: element [
	element ifNil: [ ^ self ].
	element isPoint ifTrue: [ ^ self ].
	element connectedEdges remove: self ifAbsent: [  ].

]

{ #category : #rendering }
RSEdge >> renderOn: v [
	super renderOn: v.
	self update.
]

{ #category : #private }
RSEdge >> setAnchor: ref element: anObject [
	
	(ref isNotNil and: [ anObject isPoint not ])
		ifTrue: [ ref removeConnectedEdge: self ].
	anObject ifNil: [ ^ nil ].
	anObject isPoint | anObject isBlock
		ifFalse: [ anObject addConnectedEdge: self ].
	^ anObject
]

{ #category : #accessing }
RSEdge >> to [ 	
	^ to
]

{ #category : #accessing }
RSEdge >> to: anElement [
	to := self setAnchor: to element: anElement.
]

{ #category : #updating }
RSEdge >> update [
	shape isControlPointsLine ifTrue: [ 
		^ self updateWithControlPoints.
	].
	shape 
		startPoint: (attachPoint startingPointOf: self);
		endPoint: (attachPoint endingPointOf: self);
		notifyExtentChanged.
]

{ #category : #updating }
RSEdge >> updateWithControlPoints [
	| cp |
	controlPoints ifNil: [ ^ self ]. 
	
	cp := controlPoints isCollection ifTrue: [  
		controlPoints collect: [ :anObject | | v |
			v := anObject value.
			v class = RSElement ifTrue: [ v := v position ].
			v ].
	] ifFalse: [ 
		controlPoints 
			value: (attachPoint startingPointOf: self)
			value: (attachPoint endingPointOf: self)
	].

	shape controlPoints: cp; notifyExtentChanged.
]
