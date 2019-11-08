"
I represent composite elements for Roassal3, I keep the reference to my children elements.
"
Class {
	#name : #RSCompositeElement,
	#superclass : #RSAbstractElement,
	#instVars : [
		'children'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #accessing }
RSCompositeElement >> add: child [
	child isRoassalElement ifFalse: [ ^ shape addShape: child ].
	child 
		renderOn: shape;
		addedIn: self.
		
	
]

{ #category : #accessing }
RSCompositeElement >> addAll: aTSGroup [
	children ifNil: [ children := RSGroup new: aTSGroup size ].
	aTSGroup do: [ :child | self add: child ].
]

{ #category : #'accessing - children' }
RSCompositeElement >> addEdge: aChild [
	children add: aChild
]

{ #category : #'accessing - children' }
RSCompositeElement >> addElement: aChild [
	children add: aChild
]

{ #category : #'accessing - children' }
RSCompositeElement >> children [
	^ children
]

{ #category : #testing }
RSCompositeElement >> hasChildren [
	^ children notNil and: [children notEmpty]
]

{ #category : #accessing }
RSCompositeElement >> removeElement: anElement [
	children remove: anElement ifAbsent: [ ].
	anElement shape remove.
]

{ #category : #accessing }
RSCompositeElement >> shapeFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ children ifNotNil: [ children shapeFromModel: anObject ]

]

{ #category : #accessing }
RSCompositeElement >> shapes: aTSGroup [
	self addAll: aTSGroup.
	shape adjustToChildren
]

{ #category : #actions }
RSCompositeElement >> translateTo: position [
	super translateTo: position.
	self hasChildren ifFalse: [ ^ self ].
	children do: [ :child | 
		child isElement 
			ifTrue: [ child updateConnectedEdges ] ].
]
