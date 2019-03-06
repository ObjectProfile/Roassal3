"
TODO
"
Class {
	#name : #RSTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
RSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
