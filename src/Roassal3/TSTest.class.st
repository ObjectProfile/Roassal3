"
I am the top class for tests
"
Class {
	#name : #TSTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Tests'
}

{ #category : #testing }
TSTest class >> isAbstract [
	^ self = TSTest
]
