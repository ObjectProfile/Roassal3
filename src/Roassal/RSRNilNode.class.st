"
Nil node for RSRenderTree
"
Class {
	#name : #RSRNilNode,
	#superclass : #RSAbstractRNode,
	#category : #'Roassal-Rendering'
}

{ #category : #adding }
RSRNilNode >> addChild: newObject [
	^ RSRNode new: newObject
]

{ #category : #testing }
RSRNilNode >> isNilNode [
	^ true
]
