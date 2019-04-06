"
I am base class for RSAlignment and RSResize
"
Class {
	#name : #RSAbstractElementHandling,
	#superclass : #RSObject,
	#instVars : [
		'elements',
		'fixedElement'
	],
	#category : #'Roassal3-Utils-AlignementAndResize'
}

{ #category : #accessing }
RSAbstractElementHandling >> elements [
	^ elements
]

{ #category : #accessing }
RSAbstractElementHandling >> elements: someElements [
	elements := someElements asGroup
]

{ #category : #accessing }
RSAbstractElementHandling >> fixedElement [
	^ fixedElement
]

{ #category : #accessing }
RSAbstractElementHandling >> fixedElement: anElement [
	"Designate a particular element for which all the other will be aligned against"
	fixedElement := anElement
]

{ #category : #'private - configuration' }
RSAbstractElementHandling >> ifNoFixedElementThen: aBlock [
	fixedElement ifNil: [ aBlock value  ]
]
