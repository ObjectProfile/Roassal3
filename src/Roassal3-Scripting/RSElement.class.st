"
Too abstract at this point, do we need instances of RSElement?
"
Class {
	#name : #RSElement,
	#superclass : #RSAbstractElement,
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #'accessing - children' }
RSElement >> children [
	^ #()
]

{ #category : #testing }
RSElement >> hasChildren [
	^ false
]
