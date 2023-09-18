"
This trait defines a group of utility methods to store information about a node during the layout process of `RSLayout >> #doExecute:`
"
Trait {
	#name : #RSTLayoutProperties,
	#category : #'Roassal-Layouts-Traits'
}

{ #category : #utilities }
RSTLayoutProperties >> fatherOf: aNode [
	^ aNode propertyAt: #father
]

{ #category : #utilities }
RSTLayoutProperties >> fatherOf: aNode put: aValue [
	aNode propertyAt: #father put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> layerOf: aNode [
	^ aNode propertyAt: #layout
]

{ #category : #utilities }
RSTLayoutProperties >> layerOf: aNode put: aValue [
	aNode propertyAt: #layout put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> leftContourOf: aNode [
	^ aNode propertyAt: #leftContour
]

{ #category : #utilities }
RSTLayoutProperties >> leftContourOf: aNode put: aValue [
	aNode propertyAt: #leftContour put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> modOf: aNode [
	^ aNode propertyAt: #mod ifAbsent: [ 0 ]
]

{ #category : #utilities }
RSTLayoutProperties >> modOf: aNode put: aFloat [
	aNode propertyAt: #mod put: aFloat
]

{ #category : #utilities }
RSTLayoutProperties >> pointerOf: aNode [
	^ aNode propertyAt: #pointer
]

{ #category : #utilities }
RSTLayoutProperties >> pointerOf: aNode put: aValue [
	^ aNode propertyAt: #pointer put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> rOf: aNode [
	^ aNode propertyAt: #r ifAbsent: [ 0 ]
]

{ #category : #utilities }
RSTLayoutProperties >> rOf: aNode put: aValue [
	^ aNode propertyAt: #r put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> rightContourOf: aNode [
	^ aNode propertyAt: #rightContour
]

{ #category : #utilities }
RSTLayoutProperties >> rightContourOf: aNode put: aValue [
	aNode propertyAt: #rightContour put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> thetaOf: aNode [
	^ aNode propertyAt: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utilities }
RSTLayoutProperties >> thetaOf: aNode put: aValue [
	^ aNode propertyAt: #theta put: aValue
]

{ #category : #utilities }
RSTLayoutProperties >> xOf: aNode [
	^ aNode propertyAt: #x ifAbsent: [ 0 ]
]

{ #category : #utilities }
RSTLayoutProperties >> xOf: aNode put: aValue [
	aNode propertyAt: #x put: aValue
]
