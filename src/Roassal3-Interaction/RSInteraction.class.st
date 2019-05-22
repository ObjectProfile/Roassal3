"
I am the top class for interactions in roassal
"
Class {
	#name : #RSInteraction,
	#superclass : #RSObject,
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSInteraction class >> onElement: element [
	^ self uniqueInstance onElement: element
]

{ #category : #'instance creation' }
RSInteraction class >> reset [
	<script: 'self reset'>
	instance := nil
]

{ #category : #'instance creation' }
RSInteraction class >> uniqueInstance [
	^ instance ifNil: [ instance := self new ].
]

{ #category : #hooks }
RSInteraction >> onElement: anElement [

	self subclassResponsibility 
	
]
