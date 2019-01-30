"
A TSShapeTest is a test class for testing the behavior of TSShape
"
Class {
	#name : #TSShapeTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSShapeTest >> testDrawBox [

]

{ #category : #tests }
TSShapeTest >> testPosition [
	| b |
	b := TSBox new.
	b position: 0@0.
]
