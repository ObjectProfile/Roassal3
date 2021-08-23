"
TODO
"
Class {
	#name : #RSTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'private - hook' }
RSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
