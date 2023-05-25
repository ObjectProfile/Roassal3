"
TODO
"
Class {
	#name : #RSTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : #'Roassal3-Layouts-Tree'
}

{ #category : #'private - hook' }
RSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
