"
I am the abstract root class of weighted circle layout. Look at the class comments of my subclasses for more details.
"
Class {
	#name : #RSAbstractWeightedCircleLayout,
	#superclass : #RSCircleLayout,
	#category : #'Roassal-Layouts-Circle'
}

{ #category : #testing }
RSAbstractWeightedCircleLayout class >> isAbstract [
	^ self = RSAbstractWeightedCircleLayout
]

{ #category : #hook }
RSAbstractWeightedCircleLayout >> doExecute: elements [
	"This method is used polymorphically"
]

{ #category : #hook }
RSAbstractWeightedCircleLayout >> weightSum: elements [
	"Computes the sum of all elements 'weight' or size"
	| sum |
	sum := 0.
	elements
		do: [ :each |
			sum := sum + (each height)
		].
	^sum
]
