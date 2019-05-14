"
I am the top class for interactions in roassal
"
Class {
	#name : #RSInteraction,
	#superclass : #RSObject,
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSInteraction class >> onElement: element [
	^ self new onElement: element
]

{ #category : #hooks }
RSInteraction >> onElement: anElement [

	self subclassResponsibility 
	
]
