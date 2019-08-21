"
I am a base class for interactions specific to RTGrapher.
"
Class {
	#name : #RTGrapherInteraction,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Grapher-Builder-Grapher-Core'
}

{ #category : #testing }
RTGrapherInteraction class >> isAbstract [
	^ self = RTGrapherInteraction 
]
