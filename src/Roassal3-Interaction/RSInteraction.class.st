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
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSInteraction class >> onShape: aShape [
	| inst |
	inst := self new.
	inst onShape: aShape.
	^ inst
]

{ #category : #hooks }
RSInteraction >> onShape: aShape [
	self subclassResponsibility
]
