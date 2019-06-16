Class {
	#name : #S2ECE,
	#superclass : #Object,
	#category : #'Spy2-ExecutionComparison-Example'
}

{ #category : #inline }
S2ECE >> barNegative [
]

{ #category : #inline }
S2ECE >> barPositive [
	
]

{ #category : #inline }
S2ECE >> foo: nb [
	nb > 0 ifTrue: [ self barPositive ].
	nb < 0 ifTrue: [ self barNegative ]
]
