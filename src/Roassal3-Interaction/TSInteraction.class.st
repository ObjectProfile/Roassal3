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
	#name : #TSInteraction,
	#superclass : #TSObject,
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
TSInteraction class >> instance [
	^ instance ifNil: [ instance := self new ].
]

{ #category : #'instance creation' }
TSInteraction class >> onShape: aShape [
	| inst |
	inst := self wantsUniqueInstance 
		ifTrue: [ self instance ]
		ifFalse: [ self new ].
	inst onShape: aShape.
	^ inst
]

{ #category : #'instance creation' }
TSInteraction class >> reset [
	<script: 'self reset'>
	instance := nil
]

{ #category : #'instance creation' }
TSInteraction class >> wantsUniqueInstance [ 
	^ false
]

{ #category : #hooks }
TSInteraction >> onShape: aShape [
	self subclassResponsibility 
	
]
