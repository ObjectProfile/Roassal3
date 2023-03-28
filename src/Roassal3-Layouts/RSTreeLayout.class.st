"
TODO
"
Class {
	#name : #RSTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'private - hook' }
RSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
