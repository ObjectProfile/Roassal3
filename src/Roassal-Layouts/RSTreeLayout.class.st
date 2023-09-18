"
The `RSTreeLayout` class implements a layout algorithm for arranging nodes in a tree structure. It places nodes in a hierarchical structure with a single root node at the top and child nodes arranged below their parents.

Also known as RSVerticalTreeLayout
"
Class {
	#name : #RSTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #'private - hook' }
RSTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
