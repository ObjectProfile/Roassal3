"
I am the top class for tests
"
Class {
	#name : #RSTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Tests'
}

{ #category : #testing }
RSTest class >> isAbstract [
	^ self = RSTest
]
