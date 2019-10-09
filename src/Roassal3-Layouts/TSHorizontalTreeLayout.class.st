"
TODO
"
Class {
	#name : #TSHorizontalTreeLayout,
	#superclass : #TSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
TSHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
