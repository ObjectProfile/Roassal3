"
TODO
"
Class {
	#name : #RSHorizontalTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
RSHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
