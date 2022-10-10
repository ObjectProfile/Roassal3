"
Nil node for RSRenderTree
"
Class {
	#name : #RSRNilNode,
	#superclass : #RSAbstractRNode,
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSRNilNode >> addChild: newObject [
	^ RSRNode new: newObject
]

{ #category : #testing }
RSRNilNode >> isNilNode [
	^ true
]
