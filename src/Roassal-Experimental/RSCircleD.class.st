"
I am an example
"
Class {
	#name : #RSCircleD,
	#superclass : #Object,
	#instVars : [
		'indices',
		'position',
		'radius'
	],
	#category : #'Roassal3-Experimental-Delaunay'
}

{ #category : #accessing }
RSCircleD >> i [
	^ indices first
]

{ #category : #accessing }
RSCircleD >> indices [
	^ indices
]

{ #category : #accessing }
RSCircleD >> indices: array [
	indices := array
]

{ #category : #accessing }
RSCircleD >> isRespectLimit: n [
	^ indices allSatisfy: [ :i | i <= n ]
]

{ #category : #accessing }
RSCircleD >> j [
	^ indices second
]

{ #category : #accessing }
RSCircleD >> k [
	^ indices third
]

{ #category : #accessing }
RSCircleD >> position: point [
	position := point
]

{ #category : #accessing }
RSCircleD >> radius [
	^ radius
]

{ #category : #accessing }
RSCircleD >> radius: number [
	radius := number
]

{ #category : #accessing }
RSCircleD >> x [
	^ position x
]

{ #category : #accessing }
RSCircleD >> y [
	^ position y
]
