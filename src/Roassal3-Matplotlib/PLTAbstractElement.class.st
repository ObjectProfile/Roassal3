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
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #rendering }
PLTAbstractElement >> spine [
	"Return the Trachel shape that describe the spine"
	^ (plt decorations
		detect: [ :d | d class == PLTSpineDecoration ]
		ifNone: [ self error: 'No spine is added in the plt, you need to add one' ])
		shape
]
