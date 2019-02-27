Class {
	#name : #RSNormalizer,
	#superclass : #RSObject,
	#instVars : [
		'scale',
		'executeBlock',
		'elements',
		'scaleRange'
	],
	#category : #'Roassal3-Scales-Normalizer'
}

{ #category : #accessing }
RSNormalizer class >> color [
	| n |
	n := self new.
	n from: Color green.
	n to: Color red.
	n executeBlock: [ :rsElement :aOneArgBlockOrSymbol | rsElement color: (n scale scale: (aOneArgBlockOrSymbol rsValue: rsElement model)) ].
	^ n
]

{ #category : #accessing }
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
	scale range: { aValue . scale range second }
]

{ #category : #initialization }
RSNormalizer >> initialize [
	super initialize.
	scale := TSScale linear.
	scaleRange := #(0.0 1.0).
	elements := #()
]

{ #category : #accessing }
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
	scale range: { scale range first . aValue }
]
