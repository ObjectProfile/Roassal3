Class {
	#name : #RSRDGeneratorTest,
	#superclass : #TestCase,
	#category : #'Roassal3-ReferenceDocumentation'
}

{ #category : #tests }
RSRDGeneratorTest >> testIsKeyClass [

	| g |
	g := RSRDGenerator new.
	self deny: (g isKeyClass: Object).
	self assert: (g isKeyClass: RSCamera)
]
