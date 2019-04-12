"
I am a new version of RTConstraint

I am iteratively buildable constraint for moving and positioning an element on top of another one.

!! Usage

The order of configuration message sends is irrelevant, only the last of a group will be used.

"
Class {
	#name : #RSLocate,
	#superclass : #RSObject,
	#instVars : [
		'fixedElement',
		'movableElement',
		'padding',
		'orientation',
		'direction',
		'fixedX',
		'fixedY'
	],
	#category : #'Roassal3-Utils-Normalizer'
}

{ #category : #'public - positioning shorcuts' }
RSLocate >> above [ 
	self top; outer.
]

{ #category : #'public - positioning shorcuts' }
RSLocate >> below [ 
	self bottom; outer
]

{ #category : #'public - modifiers' }
RSLocate >> border [
	orientation := 0
]

{ #category : #'public - positioning' }
RSLocate >> bottom [
	fixedY := #bottom.
	direction := direction x@ -1.
]

{ #category : #'public - positioning' }
RSLocate >> center [
	fixedX := [:rec | rec rsCenter x].
	direction := 0@ direction y
]

{ #category : #private }
RSLocate >> computePosition [
	" movableElement width / 2 + horizontalPadding * orientation * directionX + self parentX
	 movableElement height / 2 + verticalPadding * orientation * directionY + self parentY"
	 ^ movableElement extent / 2 + padding * orientation * direction + self parentPosition.
]

{ #category : #accessing }
RSLocate >> fix [
	^ fixedElement
]

{ #category : #accessing }
RSLocate >> fix: targetShape [
	fixedElement := targetShape
]

{ #category : #initialization }
RSLocate >> initialize [
	super initialize.
	direction := 0@0.
	self
		padding: 0;
		inner;
		middle;
		center
]

{ #category : #'public - modifiers' }
RSLocate >> inner [
	orientation := 1
]

{ #category : #'public - positioning' }
RSLocate >> left [
	fixedX := #left.
	direction := 1@ direction y
]

{ #category : #'public - positioning' }
RSLocate >> middle [
	fixedY := [ :r | r rsCenter y ].
	direction := direction x @ 0
]

{ #category : #accessing }
RSLocate >> movable [
	^ movableElement
]

{ #category : #accessing }
RSLocate >> movable: aShape [
	movableElement := aShape
]

{ #category : #'public - executing' }
RSLocate >> move [
	movableElement translateTo: self computePosition.
]

{ #category : #'public - modifiers' }
RSLocate >> outer [
	orientation := -1
]

{ #category : #'public - modifiers' }
RSLocate >> padding [
	^ padding
]

{ #category : #'public - modifiers' }
RSLocate >> padding: aNumber [
	padding := aNumber asPoint
]

{ #category : #private }
RSLocate >> parentPosition [
	| rec |
	rec := fixedElement encompassingRectangle.
	^ (fixedX value: rec)@ (fixedY value: rec).
]

{ #category : #'public - positioning' }
RSLocate >> right [
	fixedX := #right.
	direction := -1@direction y.
]

{ #category : #'public - executing' }
RSLocate >> stick [ 
	| block |
	self move.
	block := [ self move ].
	fixedElement 
		when: TSExtentChangedEvent do: block;
		when: TSPositionChangedEvent do: block.
]

{ #category : #'public - positioning' }
RSLocate >> top [
	fixedY := #top.
	direction := direction x @ 1
]
