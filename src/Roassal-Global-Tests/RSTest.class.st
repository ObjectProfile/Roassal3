"
I am the top class for tests
"
Class {
	#name : #RSTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Global-Tests-Core'
}

{ #category : #testing }
RSTest class >> isAbstract [
	^ self = RSTest
]

{ #category : #asserting }
RSTest >> assertIntegerPosition: shapes equals: anArray [
	self 
		assert: (shapes collect: [ :each | each position asIntegerPoint ] as: Array)
		equals: anArray
]
