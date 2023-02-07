"
TODO
"
Class {
	#name : #RSHorizontalTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'private - hook' }
RSHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
