"
TODO
"
Class {
	#name : #TSLayout,
	#superclass : #TSObject,
	#instVars : [
		'translator'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
TSLayout class >> isAbstract [
	^ self name = #TSLayout
]

{ #category : #public }
TSLayout class >> isNotAbstract [
	^ self isAbstract not
]

{ #category : #public }
TSLayout class >> on: aCollection [
	"main entry point of the class"
	
	"If aCollection is empty, then there is not much to do"
	aCollection isEmpty ifTrue: [ ^ aCollection ].
	self new applyOn: aCollection.
	^ aCollection
]

{ #category : #public }
TSLayout class >> on: elements edges: edges [
	"To make all the layout polymorphic"
	
	^ self on: elements 
]

{ #category : #public }
TSLayout class >> onElement: aRoassalViewOrRoassalElement [

	^ self on: aRoassalViewOrRoassalElement elements
]

{ #category : #public }
TSLayout class >> onView: aRoassalView [

	^ self on: aRoassalView elements
]

{ #category : #hook }
TSLayout >> applyOn: elements [
	"Return quickly if there is nothing to do"
	elements isEmpty ifTrue: [ ^ self ].
	self executeOnElements: elements
]

{ #category : #hook }
TSLayout >> doExecute: elements [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
TSLayout >> doInitialize: elements [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
	"self announce: (ROLayoutBegin new elements: elements)."
]

{ #category : #hook }
TSLayout >> doPost: elements [
	"Method executed after performing the layout"

]

{ #category : #hook }
TSLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"
		
	self doInitialize: elements.
	self doExecute: elements asOrderedCollection.
	self doPost: elements.

]

{ #category : #utils }
TSLayout >> fatherOf: aNode [
	^ aNode attributes at: #father ifAbsent: [ nil ]
]

{ #category : #utils }
TSLayout >> fatherOf: aNode put: aValue [
	aNode attributes at: #father put: aValue
]

{ #category : #'initialize-release' }
TSLayout >> initialize [
	super initialize.
	translator := TSLayoutTranslator default
]

{ #category : #testing }
TSLayout >> isEdgeDrivenLayout [
	^ false
]

{ #category : #utils }
TSLayout >> layerOf: aNode [
	^ aNode attributes at: #layout
]

{ #category : #utils }
TSLayout >> layerOf: aNode put: aValue [
	aNode attributes at: #layout put: aValue
]

{ #category : #utils }
TSLayout >> leftContourOf: aNode [
	^ aNode attributes at: #leftContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TSLayout >> leftContourOf: aNode put: aValue [
	aNode attributes at: #leftContour put: aValue
]

{ #category : #utils }
TSLayout >> modOf: aNode [
	^ aNode attributes at: #mod ifAbsent: [ ^ 0 ]

]

{ #category : #utils }
TSLayout >> modOf: aNode put: aFloat [
	aNode attributes at: #mod put: aFloat

]

{ #category : #hook }
TSLayout >> on: elements [
	self applyOn: elements
]

{ #category : #hook }
TSLayout >> on: elements edges: edges [
	self applyOn: elements
]

{ #category : #utils }
TSLayout >> pointerOf: aNode [

	^ aNode attributes at: #pointer ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TSLayout >> pointerOf: aNode put: aValue [

	^ aNode attributes at: #pointer put: aValue
]

{ #category : #utils }
TSLayout >> rOf: aNode [ 
	^ aNode attributes at: #r ifAbsent: [ 0 ]
	
]

{ #category : #utils }
TSLayout >> rOf: aNode put: aValue [
	^ aNode attributes at: #r put: aValue
]

{ #category : #utils }
TSLayout >> rightContourOf: aNode [
	^ aNode attributes at: #rightContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TSLayout >> rightContourOf: aNode put: aValue [
	aNode attributes at: #rightContour put: aValue
]

{ #category : #events }
TSLayout >> step [
]

{ #category : #utils }
TSLayout >> thetaOf: aNode [
	^ aNode attributes at: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
TSLayout >> thetaOf: aNode put: aValue [
	^ aNode attributes at: #theta put: aValue
]

{ #category : #accessing }
TSLayout >> translator [
	^ translator
]

{ #category : #accessing }
TSLayout >> translator: aTranslator [
	translator := aTranslator
]

{ #category : #hook }
TSLayout >> userDefinedEdges: edges [
	"Do nothing"
]

{ #category : #utils }
TSLayout >> xOf: aNode [ 
	^ aNode attributes at: #x ifAbsent: [ 0 ]
]

{ #category : #utils }
TSLayout >> xOf: aNode put: aValue [
	aNode attributes at: #x put: aValue
]
