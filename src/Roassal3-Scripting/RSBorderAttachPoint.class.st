"
I am an attach point that will end the line on the border of the end shapes.

Unline ContinuousAttachPoint & co. you don't need to care about what the end shape is, as long as it is one of the basic shapes.
"
Class {
	#name : #RSBorderAttachPoint,
	#superclass : #RSAttachPoint,
	#instVars : [
		'offset'
	],
	#category : #'Roassal3-Scripting-AttachPoint'
}

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicEndingPointOf: anEdge [
	^ self
		positionFor: anEdge to
		point: (self basicPointFrom: anEdge to to: anEdge from of: anEdge)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicPointFrom: fromElement to: toElement of: anEdge [
	| source target line shift |
	source := fromElement geometry.
	target := toElement geometry.
	shift := self offsetNormalFor: anEdge.
	line := GLineSegment from: source center to: target center.
	shift := (line vector = (0@0) 
		ifTrue: [ -1 @ 0]
		ifFalse: [ line vector normal ]) * shift.
	anEdge from = toElement
		ifTrue: [ shift := shift * -1 ].
	line := GLineSegment from: source center + shift to: target center + shift.
	^ self borderPointFrom: source to: target via: line
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicStartingPointOf: anEdge [
	^ self
		positionFor: anEdge from 
		point: (self basicPointFrom: anEdge from to: anEdge to of: anEdge)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersect: aSource) detectMin: [ :p | p dist: aLine to ])
		ifNil: [ aSource center ]
]

{ #category : #initialization }
RSBorderAttachPoint >> initialize [
	super initialize.
	offset := 5
]

{ #category : #accessing }
RSBorderAttachPoint >> offset [
	^ offset
]

{ #category : #accessing }
RSBorderAttachPoint >> offset: aNumber [
	offset := aNumber
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> offsetNormalFor: anEdge [
	"Return the offset in case of multiple edges with the same starting and ending points"

	| indexOfEdge multipleEdges |
	multipleEdges := OrderedCollection new.
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e from == anEdge from and: [ e to == anEdge to ] ]).
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e to == anEdge from and: [ e from == anEdge to ] ]).
	multipleEdges size <= 1
		ifTrue: [ ^ 0 @ 0 ].
	indexOfEdge := multipleEdges indexOf: anEdge.
	^ (indexOfEdge - 1 - (multipleEdges size / 2)) * offset
]
