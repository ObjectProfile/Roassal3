"
TODO
"
Class {
	#name : #TSLayoutTranslator,
	#superclass : #TSObject,
	#instVars : [
		'view'
	],
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #accessing }
TSLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #accessing }
TSLayoutTranslator class >> defaultClass [
	^ self allSubclasses detect: #isDefault
]

{ #category : #'as yet unclassified' }
TSLayoutTranslator class >> isDefault [
	^ false
]

{ #category : #accessing }
TSLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #hook }
TSLayoutTranslator >> translate: element by: deltaPosition [
	"Translate of the center of the element by a step"
	self translate: element to: element position + deltaPosition
]

{ #category : #hook }
TSLayoutTranslator >> translate: element to: newPosition [
	"Translate of the center of the element"
	self subclassResponsibility 
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translate: element to: newPosition direction: aDirection [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition + (element extent / 2 * aDirection)
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateBottomLeftOf: element to: newPosition [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition direction: 1 @ -1.
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateBottomOf: element to: newPosition [
	"Translate the bottom side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ -1
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateBottomRightOf: element to: newPosition [
	"Translate the bottom right corner of the element"

	self translate: element to: newPosition direction: -1 @ -1
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateCenterLeftOf: element to: newPosition [
	"Translate the left center of the element to newPosition"

	self translate: element to: newPosition direction: 1 @ 0
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateLeftOf: element to: newPosition [
	"Translate the left side of the element"

	self translate: element to: newPosition @ element position y direction: 1 @ 0.
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateRightOf: element to: newPosition [
	"Translate the right side of the element"

	self translate: element to: newPosition @ element position y direction: -1 @ 0.
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateTopLeftOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: 1 @ 1
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateTopOf: element to: newPosition [
	"Translate the top side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ 1.
]

{ #category : #'public - translating' }
TSLayoutTranslator >> translateTopRightOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: -1 @ 1
]

{ #category : #accessing }
TSLayoutTranslator >> view [
	^ view
]

{ #category : #accessing }
TSLayoutTranslator >> view: aView [
	view := aView
]
