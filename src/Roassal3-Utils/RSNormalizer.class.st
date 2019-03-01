"
A Metric normalizer is made to assign a color, or a particular shape computed from a group of elements. Consider the following example:

"
Class {
	#name : #RSNormalizer,
	#superclass : #RSObject,
	#instVars : [
		'scale',
		'executeBlock',
		'elements'
	],
	#category : #'Roassal3-Utils-Normalizer'
}

{ #category : #'instance creation' }
RSNormalizer class >> color [ 
	| n |
	n := self new.
	n from: Color green.
	n to: Color red.
	n executeBlock: [ :rsElement :aOneArgBlockOrSymbol | rsElement color: (n scale scale: (aOneArgBlockOrSymbol rsValue: rsElement model)) ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> size [ 
	| n |
	n := self new.
	n from: 5 @ 5.
	n to: 100 @ 100.
	n executeBlock: [ :rsElement :aOneArgBlockOrSymbol | rsElement size: (n scale scale: (aOneArgBlockOrSymbol rsValue: rsElement model)) ].
	^ n

]

{ #category : #accessing }
RSNormalizer >> elements [
	^ elements

]

{ #category : #accessing }
RSNormalizer >> elements: someRSElements [
	elements := someRSElements
]

{ #category : #accessing }
RSNormalizer >> executeBlock [
	^ executeBlock
]

{ #category : #accessing }
RSNormalizer >> executeBlock: anOneArgBlock [
	executeBlock := anOneArgBlock
]

{ #category : #accessing }
RSNormalizer >> from: aValue [
	scale from: aValue
]

{ #category : #initialization }
RSNormalizer >> initialize [
	super initialize.
	scale := TSScale linear.
	elements := #()

]

{ #category : #normalizer }
RSNormalizer >> normalize: anOneArgBlockOrSymbol [ 
	| minAndMax |
	minAndMax := elements inject: { SmallInteger maxVal . SmallInteger minVal } into: [ :res :anElement | 
		| tmp |
		tmp := anOneArgBlockOrSymbol rsValue: anElement model.
		{ res first min: tmp . res second max: tmp } ].
	scale domain: minAndMax.
	elements do: [ :anEl | executeBlock value: anEl value: anOneArgBlockOrSymbol ]

]

{ #category : #accessing }
RSNormalizer >> scale [
	^ scale

]

{ #category : #accessing }
RSNormalizer >> scale: aTSScale [
	scale := aTSScale
]

{ #category : #accessing }
RSNormalizer >> to: aValue [
	scale to: aValue

]
