Class {
	#name : #PLTAbstractElement,
	#superclass : #Object,
	#instVars : [
		'plt'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #accessing }
PLTAbstractElement >> plt [
	^ plt
]

{ #category : #accessing }
PLTAbstractElement >> plt: aPlt [
	plt := aPlt
]

{ #category : #rendering }
PLTAbstractElement >> renderIn: canvas [
	self subclassResponsibility
]
