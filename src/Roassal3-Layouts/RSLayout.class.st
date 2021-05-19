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
RSLayout >> doExecute: shapes [
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
	^ aNode propertyAt: #father
]

{ #category : #utils }
RSLayout >> fatherOf: aNode put: aValue [
	aNode propertyAt: #father put: aValue
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
	^ aNode propertyAt: #layout
]

{ #category : #utils }
RSLayout >> layerOf: aNode put: aValue [
	aNode propertyAt: #layout put: aValue
]

{ #category : #utils }
RSLayout >> leftContourOf: aNode [
	^ aNode propertyAt: #leftContour
]

{ #category : #utils }
RSLayout >> leftContourOf: aNode put: aValue [
	aNode propertyAt: #leftContour put: aValue
]

{ #category : #utils }
RSLayout >> modOf: aNode [
	^ aNode propertyAt: #mod ifAbsent: [ 0 ]

]

{ #category : #utils }
RSLayout >> modOf: aNode put: aFloat [
	aNode propertyAt: #mod put: aFloat

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
	^ aNode propertyAt: #pointer
]

{ #category : #utils }
RSLayout >> pointerOf: aNode put: aValue [
	^ aNode propertyAt: #pointer put: aValue
]

{ #category : #utils }
RSLayout >> rOf: aNode [ 
	^ aNode propertyAt: #r ifAbsent: [ 0 ]
	
]

{ #category : #utils }
RSLayout >> rOf: aNode put: aValue [
	^ aNode propertyAt: #r put: aValue
]

{ #category : #utils }
RSLayout >> rightContourOf: aNode [
	^ aNode propertyAt: #rightContour
]

{ #category : #utils }
RSLayout >> rightContourOf: aNode put: aValue [
	aNode propertyAt: #rightContour put: aValue
]

{ #category : #events }
RSLayout >> step [
]

{ #category : #utils }
RSLayout >> thetaOf: aNode [
	^ aNode propertyAt: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
RSLayout >> thetaOf: aNode put: aValue [
	^ aNode propertyAt: #theta put: aValue
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
	^ aNode propertyAt: #x ifAbsent: [ 0 ]
]

{ #category : #utils }
RSLayout >> xOf: aNode put: aValue [
	aNode propertyAt: #x put: aValue
]
