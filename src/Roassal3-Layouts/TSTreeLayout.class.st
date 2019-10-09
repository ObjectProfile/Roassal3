"
TODO
"
Class {
	#name : #TSTreeLayout,
	#superclass : #TSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
TSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
