"
I am the root class of all the examples of Roassal3. Examples contained in a subclass of myself are automatically run by the the test: TSExamplesTest>>testExamples

The goal is to make the examples part of the tests.
If you wish to add examples to Roassal3, then you need to subclass me.
"
Class {
	#name : #RSAbstractExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples-Core'
}

{ #category : #accessing }
RSAbstractExamples >> label [
	^ self className
]

{ #category : #accessing }
RSAbstractExamples >> order [
	^ 100
]
