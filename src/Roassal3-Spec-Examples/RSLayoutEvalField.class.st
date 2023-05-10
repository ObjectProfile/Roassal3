"
Used to evaluate some objects and values
"
Class {
	#name : #RSLayoutEvalField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #accessing }
RSLayoutEvalField >> transform: aString [
	| point |
	point := self class compiler evaluate: aString.
	point ifNil: [ ^ nil ].
	^ point
]
