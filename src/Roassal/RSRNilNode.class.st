"
Nil node for RSRenderTree
"
Class {
	#name : 'RSRNilNode',
	#superclass : 'RSAbstractRNode',
	#category : 'Roassal-Rendering',
	#package : 'Roassal',
	#tag : 'Rendering'
}

{ #category : 'examples' }
RSRNilNode class >> example [
	| null |
	null := self new.
	"this object defines nil operations for RNode"
	null do: [ :each | 1/0 ].
	^ StInspector openOn: null.
]

{ #category : 'adding' }
RSRNilNode >> addChild: newObject [
	^ RSRNode new: newObject
]

{ #category : 'testing' }
RSRNilNode >> isNilNode [
	^ true
]
