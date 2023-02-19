"
I can move an element from its position
"
Class {
	#name : #RSDraggable,
	#superclass : #RSInteraction,
	#instVars : [
		'shouldValidateChildrenEvents'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSDraggable class >> wantsUniqueInstance [
	^ true
]

{ #category : #public }
RSDraggable >> checkChildrenActions: aShape [
	| children |
	self shouldValidateChildrenEvents ifFalse: [ ^ self ].
	children := aShape children.
	children ifNil: [ ^ self ].
	"To disable this check"
	"RSDraggable new noValidateChildrenEvents"
	self assert: (children allSatisfy: [ :each |
		(each handleAnnouncementClass: RSMouseDragging) not
		 ] ) description: 'Children shapes should not contains the same interaction'
]

{ #category : #initialization }
RSDraggable >> initialize [
	super initialize.
	self withValidateChildrenEvents
]

{ #category : #public }
RSDraggable >> noValidateChildrenEvents [
	shouldValidateChildrenEvents := false
]

{ #category : #hooks }
RSDraggable >> onShape: aShape [
	self checkChildrenActions: aShape.
	aShape when: RSMouseDragging send: #processDrag: to: self
]

{ #category : #events }
RSDraggable >> processDrag: evt [
	| d |
	d := evt camera distanceFromPixelToSpace: evt step.
	evt shape translateBy: d.
	evt signalUpdate
]

{ #category : #testing }
RSDraggable >> shouldValidateChildrenEvents [
	^ shouldValidateChildrenEvents ifNil: [ ^ false ]
]

{ #category : #public }
RSDraggable >> withValidateChildrenEvents [
	shouldValidateChildrenEvents := true
]
