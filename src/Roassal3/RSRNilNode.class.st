"
Nil node for RSRenderTree
"
Class {
	#name : 'RSRNilNode',
	#superclass : 'RSAbstractRNode',
	#category : 'Roassal3-Rendering',
	#package : 'Roassal3',
	#tag : 'Rendering'
}

{ #category : 'adding' }
RSRNilNode >> addChild: newObject [
	^ RSRNode new: newObject
]

{ #category : 'testing' }
RSRNilNode >> isNilNode [
	^ true
]
