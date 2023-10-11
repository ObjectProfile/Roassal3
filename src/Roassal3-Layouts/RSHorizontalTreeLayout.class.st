"
Regular Hoorizontal tree layout, similar to `RSTreeLayout` but horizontal direction
"
Class {
	#name : 'RSHorizontalTreeLayout',
	#superclass : 'RSAbstractHorizontalTreeLayout',
	#traits : 'RSTLayoutProperties',
	#classTraits : 'RSTLayoutProperties classTrait',
	#category : 'Roassal3-Layouts-Tree',
	#package : 'Roassal3-Layouts',
	#tag : 'Tree'
}

{ #category : 'private - hook' }
RSHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
