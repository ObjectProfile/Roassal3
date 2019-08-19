"
TODO
"
Class {
	#name : #RSLayout,
	#superclass : #RSObject,
	#instVars : [
		'translator'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSLayout class >> isAbstract [
	^ self name = #RSLayout
]

{ #category : #public }
RSLayout class >> isNotAbstract [
	^ self isAbstract not
]

{ #category : #public }
RSLayout class >> on: aCollection [
	"main entry point of the class"
	
	"If aCollection is empty, then there is not much to do"
	aCollection isEmpty ifTrue: [ ^ aCollection ].
	self new applyOn: aCollection.
	^ aCollection
]

{ #category : #public }
RSLayout class >> on: elements edges: edges [
	"To make all the layout polymorphic"
	
	^ self on: elements 
]

{ #category : #public }
RSLayout class >> onElement: aRoassalViewOrRoassalElement [

	^ self on: aRoassalViewOrRoassalElement elements
]

{ #category : #public }
RSLayout class >> onView: aRoassalView [

	^ self on: aRoassalView elements
]

{ #category : #hook }
RSLayout >> applyOn: elements [
	"Return quickly if there is nothing to do"
	elements isEmpty ifTrue: [ ^ self ].
	self executeOnElements: elements
]

{ #category : #hook }
RSLayout >> doExecute: elements [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
RSLayout >> doInitialize: elements [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
	"self announce: (ROLayoutBegin new elements: elements)."
]

{ #category : #hook }
RSLayout >> doPost: elements [
	"Method executed after performing the layout"

]

{ #category : #hook }
RSLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"
		
	self doInitialize: elements.
	self doExecute: elements asOrderedCollection.
	self doPost: elements.

]

{ #category : #utils }
RSLayout >> fatherOf: aNode [
	^ aNode attributes at: #father ifAbsent: [ nil ]
]

{ #category : #utils }
RSLayout >> fatherOf: aNode put: aValue [
	aNode attributes at: #father put: aValue
]

{ #category : #'initialize-release' }
RSLayout >> initialize [
	super initialize.
	translator := RSLayoutTranslator default
]

{ #category : #testing }
RSLayout >> isEdgeDrivenLayout [
	^ false
]

{ #category : #utils }
RSLayout >> layerOf: aNode [
	^ aNode attributes at: #layout
]

{ #category : #utils }
RSLayout >> layerOf: aNode put: aValue [
	aNode attributes at: #layout put: aValue
]

{ #category : #utils }
RSLayout >> leftContourOf: aNode [
	^ aNode attributes at: #leftContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RSLayout >> leftContourOf: aNode put: aValue [
	aNode attributes at: #leftContour put: aValue
]

{ #category : #utils }
RSLayout >> modOf: aNode [
	^ aNode attributes at: #mod ifAbsent: [ ^ 0 ]

]

{ #category : #utils }
RSLayout >> modOf: aNode put: aFloat [
	aNode attributes at: #mod put: aFloat

]

{ #category : #hook }
RSLayout >> on: elements [
	self applyOn: elements
]

{ #category : #hook }
RSLayout >> on: elements edges: edges [
	self applyOn: elements
]

{ #category : #utils }
RSLayout >> pointerOf: aNode [

	^ aNode attributes at: #pointer ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RSLayout >> pointerOf: aNode put: aValue [

	^ aNode attributes at: #pointer put: aValue
]

{ #category : #utils }
RSLayout >> rOf: aNode [ 
	^ aNode attributes at: #r ifAbsent: [ 0 ]
	
]

{ #category : #utils }
RSLayout >> rOf: aNode put: aValue [
	^ aNode attributes at: #r put: aValue
]

{ #category : #utils }
RSLayout >> rightContourOf: aNode [
	^ aNode attributes at: #rightContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RSLayout >> rightContourOf: aNode put: aValue [
	aNode attributes at: #rightContour put: aValue
]

{ #category : #events }
RSLayout >> step [
]

{ #category : #utils }
RSLayout >> thetaOf: aNode [
	^ aNode attributes at: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
RSLayout >> thetaOf: aNode put: aValue [
	^ aNode attributes at: #theta put: aValue
]

{ #category : #accessing }
RSLayout >> translator [
	^ translator
]

{ #category : #accessing }
RSLayout >> translator: aTranslator [
	translator := aTranslator
]

{ #category : #hook }
RSLayout >> userDefinedEdges: edges [
	"Do nothing"
]

{ #category : #utils }
RSLayout >> xOf: aNode [ 
	^ aNode attributes at: #x ifAbsent: [ 0 ]
]

{ #category : #utils }
RSLayout >> xOf: aNode put: aValue [
	aNode attributes at: #x put: aValue
]
