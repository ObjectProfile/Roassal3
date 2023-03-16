"
I am the top class for interactions in roassal.

You can add an interaction to an instance of RSElement or RSEdge or RSView with: 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
element addInteraction: RSDraggable.
edge addInteraction: (RSHighlightable new).
view @ RSDraggableView.
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

"
Class {
	#name : #RSInteraction,
	#superclass : #RSObject,
	#classVars : [
		'instance'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSInteraction class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #'instance creation' }
RSInteraction class >> onShape: aShape [
	| inst |
	inst := self wantsUniqueInstance
		ifTrue: [ self instance ]
		ifFalse: [ self new ].
	inst onShape: aShape.
	^ inst
]

{ #category : #'class initialization' }
RSInteraction class >> reset [
	<script: 'self reset'>
	instance := nil
]

{ #category : #'instance creation' }
RSInteraction class >> wantsUniqueInstance [
	^ false
]

{ #category : #hooks }
RSInteraction >> onShape: aShape [
	self subclassResponsibility
]
