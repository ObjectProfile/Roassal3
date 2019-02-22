"
A ROTreeLayout is xxxxxxxxx.

"
Class {
	#name : #RTTreeLayout,
	#superclass : #RTAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts'
}

{ #category : #'hook-private' }
RTTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
