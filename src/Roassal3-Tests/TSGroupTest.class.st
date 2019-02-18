"
A TSGroupTest is a test class for testing the behavior of TSGroup
"
Class {
	#name : #TSGroupTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSGroupTest >> testAddShape [
	| g |
	g := TSGroup new.
	g addShape: TSBox new.
]
