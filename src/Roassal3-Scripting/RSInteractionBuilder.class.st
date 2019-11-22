"
I a m the interaction builder
"
Class {
	#name : #RSInteractionBuilder,
	#superclass : #RSObject,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #adding }
RSInteractionBuilder >> addExclusiveInteraction: anInteraction [
	"We only keep all the interaction that have a different class"
	interactions := interactions select: [ :i | i class ~~ anInteraction class ].
	self addInteraction: anInteraction
]

{ #category : #adding }
RSInteractionBuilder >> addInteraction: anInteraction [
	interactions add: anInteraction
]

{ #category : #interactions }
RSInteractionBuilder >> browseable [
	self addInteraction: [ :element | element when: RSMouseClick do: [ :evt | element model browse ] ].
]

{ #category : #interactions }
RSInteractionBuilder >> clear [
	interactions removeAll.
]

{ #category : #interactions }
RSInteractionBuilder >> draggable [
	| i |
	self addExclusiveInteraction: (i := RSDraggable instance).
	^ i
	
]

{ #category : #initialization }
RSInteractionBuilder >> initialize [
	super initialize.
	interactions := OrderedCollection new.
]

{ #category : #actions }
RSInteractionBuilder >> inspectable [
	self addInteraction: [ :element | element when: RSMouseClick do: [ :evt | element model inspect ] ].
]

{ #category : #interactions }
RSInteractionBuilder >> labeled [
	| i |
	self addExclusiveInteraction: (i := RSLabeled new).
	^ i
	
]

{ #category : #interactions }
RSInteractionBuilder >> labeledHighlightable [
	| i |
	i := self labeled.
	i highlightable.
	^ i
]

{ #category : #interactions }
RSInteractionBuilder >> popup [
	^ self popupText: #yourself
]

{ #category : #interactions }
RSInteractionBuilder >> popupAndDraggable [
	self popup.
	self draggable.
]

{ #category : #interactions }
RSInteractionBuilder >> popupText: anObject [
	| i |
	self addExclusiveInteraction: (i := RSPopup new).
	i shapeBuilder textBlock: anObject.
	^ i.
]

{ #category : #initialization }
RSInteractionBuilder >> setUpElement: elementOrGroup [
	"elements is an RTGroup, that contains RTElement or RTEdges"
	
	interactions do: [ :int | elementOrGroup @ int ]
]

{ #category : #interactions }
RSInteractionBuilder >> when: event do: block [
	self addInteraction: [ :element | element when: event do: block ]
]
