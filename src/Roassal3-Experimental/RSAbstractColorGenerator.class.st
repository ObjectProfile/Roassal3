"
TODO
"
Class {
	#name : #RSAbstractColorGenerator,
	#superclass : #RSObject,
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSAbstractColorGenerator >> backgroundColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractColorGenerator >> colorFor: aParticle [
	self subclassResponsibility
]
