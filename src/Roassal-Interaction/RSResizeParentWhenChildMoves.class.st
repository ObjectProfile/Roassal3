"
Based on simple moves of inner children, this interactions allow nodes to keep in the parent and update it
"
Class {
	#name : 'RSResizeParentWhenChildMoves',
	#superclass : 'RSAbstractCanvasInteraction',
	#instVars : [
		'padding'
	],
	#category : 'Roassal-Interaction-Core',
	#package : 'Roassal-Interaction',
	#tag : 'Core'
}

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> brotherFor: shape from: children [
	^ children
		detect: [ :child | child ~= shape ]
		ifNone: [ nil ]
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> childrenFor: parent [
	^ parent children
]

{ #category : 'initialization' }
RSResizeParentWhenChildMoves >> defaultPadding [
	^ 10
]

{ #category : 'initialization' }
RSResizeParentWhenChildMoves >> initialize [
	super initialize.
	self padding: self defaultPadding
]

{ #category : 'testing' }
RSResizeParentWhenChildMoves >> isValidParent: parent [
	^ parent isNotNil and: [ parent isShape ]
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> onShape: aCanvas [
	aCanvas isShape
		ifTrue: [ ^ self registerShape: aCanvas ].

	aCanvas allChildren do: [ :child | self registerShape: child ]
]

{ #category : 'accessing' }
RSResizeParentWhenChildMoves >> padding [
	^ padding
]

{ #category : 'accessing' }
RSResizeParentWhenChildMoves >> padding: aNumberPointOrMargin [
	padding := aNumberPointOrMargin
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> parentFor: shape [
	^ shape parent
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> prepare: shape with: parent [
	"do nothing"
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> registerShape: child [
	child
		when: RSPositionChangedEvent
		send: #resizeParent:
		to: self
]

{ #category : 'hooks' }
RSResizeParentWhenChildMoves >> resizeParent: evt [
	| shape parent lastPosition delta children brother reference |
	shape := evt shape.
	parent := self parentFor: shape.
	(self isValidParent: parent) ifFalse: [^ self ].

	lastPosition := parent position.
	delta := evt newPosition - evt oldPosition.
	children := self childrenFor: parent.

	brother := self brotherFor: shape from: children.
	reference := nil.
	brother ifNotNil: [
		reference := brother parent globalMatrix
			transform: brother position ].
	parent executeWithoutAnnouncer: [
		self prepare: shape with: parent.
		parent adjustToChildren.
		parent padding: self padding.
		 ].
	children size = 1 ifTrue: [
		shape position: evt oldPosition.
		parent translateTo: lastPosition + delta.
		^ self ].
	parent position: lastPosition.
	delta := (brother parent globalMatrix transform: brother position) - reference.
	parent translateBy: delta negated
]
