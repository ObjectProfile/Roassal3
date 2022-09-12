"
A BMMapBuilderTest is a test class for testing the behavior of BMMapBuilder
"
Class {
	#name : #RSMapBuilderTest,
	#superclass : #TestCase,
	#category : #'Roassal3-BaselineMap-Tests'
}

{ #category : #tests }
RSMapBuilderTest >> testAttributes [
	| map |
	map := RSMapBuilder new.
	map baseline: BaselineOfMorphic.
	self assert: map models isCollection.
	self assert: map models size > 1
	
]

{ #category : #tests }
RSMapBuilderTest >> testBasic [
	RSMapBuilder new
		baseline: BaselineOfMorphic;
		build
]
