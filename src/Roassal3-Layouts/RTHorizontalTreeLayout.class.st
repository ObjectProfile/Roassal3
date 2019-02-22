"
A ROHorizontalTreeLayout is xxxxxxxxx.

"
Class {
	#name : #RTHorizontalTreeLayout,
	#superclass : #RTAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts'
}

{ #category : #'hook-private' }
RTHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
