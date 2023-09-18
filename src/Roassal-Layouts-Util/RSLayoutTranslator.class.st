"
TODO
"
Class {
	#name : #RSLayoutTranslator,
	#superclass : #RSObject,
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'Roassal-Layouts-Util'
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

{ #category : #testing }
RSLayoutTranslator class >> isDefault [
	^ false
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

	self translate: element to: newPosition direction: 1 @ -1
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateCenterLeftOf: element to: newPosition [
	"Translate the left center of the element to newPosition"

	self translate: element to: newPosition direction: 1 @ 0
]

{ #category : #'public - translating' }
RSLayoutTranslator >> translateTopLeftOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: 1 @ 1
]
