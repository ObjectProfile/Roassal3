"
Visitor that works with `RSRNode`
"
Class {
	#name : #RSRNodeVisitor,
	#superclass : #RSObject,
	#instVars : [
		'block'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #'instance creation' }
RSRNodeVisitor class >> on: aBlock [
	^ self basicNew
		block: aBlock;
		yourself
]

{ #category : #accessing }
RSRNodeVisitor >> block [
	^ block
]

{ #category : #accessing }
RSRNodeVisitor >> block: aBlock [
	block := aBlock
]

{ #category : #visiting }
RSRNodeVisitor >> visitNode: aNode [
	block value: aNode.
	aNode childrenDo: [ :child | child accept: self ]
]
