"
I represent composite elements for Roassal3, I keep the reference to my children elements.
"
Class {
	#name : #RSComposite,
	#superclass : #RSAbstractElement,
	#instVars : [
		'children'
	],
	#category : #'Roassal3-Core'
}

{ #category : #'accessing - children' }
RSComposite >> children [
	^ children
]

{ #category : #accessing }
RSComposite >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ children ifNotNil: [ children elementFromModel: anObject ]

]

{ #category : #testing }
RSComposite >> hasChildren [
	^ children notNil and: [children notEmpty]
]

{ #category : #accessing }
RSComposite >> removeElement: anElement [
	children remove: anElement ifAbsent: [ ].
	anElement trachelShape remove.
]

{ #category : #accessing }
RSComposite >> shapes: aTSGroup [
	trachelShape shapes: aTSGroup.
	(aTSGroup allSatisfy: #isRoassalElement) ifFalse: [ ^ self ].
	children := aTSGroup.
	children do: [ :child | 
		child parent: self ].
]

{ #category : #actions }
RSComposite >> translateTo: position [
	super translateTo: position.
	self hasChildren ifFalse: [ ^ self ].
	children do: [ :child | 
		child isElement 
			ifTrue: [ child updateConnectedEdges ] ].
]
