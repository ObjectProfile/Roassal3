"
TODO
"
Class {
	#name : #RSLayoutTranslator,
	#superclass : #RSObject,
	#instVars : [
		'view'
	],
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #accessing }
RSLayoutTranslator class >> defaultClass [
	^ self allSubclasses detect: #isDefault
]

{ #category : #'as yet unclassified' }
RSLayoutTranslator class >> isDefault [
	^ false
]

{ #category : #accessing }
RSLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #hook }
RSLayoutTranslator >> translate: element by: deltaPosition [
	"Translate of the center of the element by a step"
	self translate: element to: element position + deltaPosition
]

{ #category : #hook }
RSLayoutTranslator >> translate: element to: newPosition [
	"Translate of the center of the element"
	self subclassResponsibility 
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translate: element to: newPosition direction: aDirection [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition + (element extent / 2 * aDirection)
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateBottomLeftOf: element to: newPosition [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition direction: 1 @ -1.
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateBottomOf: element to: newPosition [
	"Translate the bottom side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ -1
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateBottomRightOf: element to: newPosition [
	"Translate the bottom right corner of the element"

	self translate: element to: newPosition direction: -1 @ -1
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateCenterLeftOf: element to: newPosition [
	"Translate the left center of the element to newPosition"

	self translate: element to: newPosition direction: 1 @ 0
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateLeftOf: element to: newPosition [
	"Translate the left side of the element"

	self translate: element to: newPosition @ element position y direction: 1 @ 0.
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateRightOf: element to: newPosition [
	"Translate the right side of the element"

	self translate: element to: newPosition @ element position y direction: -1 @ 0.
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateTopLeftOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: 1 @ 1
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateTopOf: element to: newPosition [
	"Translate the top side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ 1.
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateTopRightOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: -1 @ 1
]

{ #category : #accessing }
RSLayoutTranslator >> view [
	^ view
]

{ #category : #accessing }
RSLayoutTranslator >> view: aView [
	view := aView
]
