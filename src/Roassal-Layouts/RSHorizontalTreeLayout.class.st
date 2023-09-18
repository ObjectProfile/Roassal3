"
Regular Hoorizontal tree layout, similar to `RSTreeLayout` but horizontal direction
"
Class {
	#name : #RSHorizontalTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #'private - hook' }
RSHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
