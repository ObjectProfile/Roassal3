"
I am a demo
"
Class {
	#name : #RSXmasBranch,
	#superclass : #Object,
	#instVars : [
		'positions',
		'thickness',
		'isCandidate',
		'baseIndex',
		'dTheta'
	],
	#category : #'Roassal3-Experimental-Xmas2019'
}

{ #category : #adding }
RSXmasBranch >> addBaseIndex: aPoint [
	baseIndex add: aPoint
]

{ #category : #adding }
RSXmasBranch >> addPosition: aPoint [
	positions add: aPoint
]

{ #category : #adding }
RSXmasBranch >> addThickness: aFloat [
	thickness add: aFloat
]

{ #category : #accessing }
RSXmasBranch >> baseIndex [
	^ baseIndex
]

{ #category : #public }
RSXmasBranch >> branchRotate: index theta: theta position: reference [
	| v |
	v := positions at: index.
	v := v - reference.
	v := ((v x * theta cos) - (v y * theta sin)) @
		((v x * theta sin) + (v y * theta cos)).

	v := v + reference.
	positions at: index put: v
]

{ #category : #accessing }
RSXmasBranch >> dTheta [
	^ dTheta
]

{ #category : #accessing }
RSXmasBranch >> dTheta: aCollection [
	dTheta := aCollection
]

{ #category : #initialization }
RSXmasBranch >> initialize [
	super initialize.
	positions := OrderedCollection new.
	thickness := OrderedCollection new.
	baseIndex := OrderedCollection new.
	isCandidate := false
]

{ #category : #accessing }
RSXmasBranch >> isCandidate [
	^ isCandidate
]

{ #category : #accessing }
RSXmasBranch >> isCandidate: aBool [
	isCandidate := aBool
]

{ #category : #accessing }
RSXmasBranch >> positions [
	^ positions
]

{ #category : #accessing }
RSXmasBranch >> setLastThickness: aNumber [
	thickness at: thickness size put: aNumber
]

{ #category : #accessing }
RSXmasBranch >> thickness [
	^ thickness
]
