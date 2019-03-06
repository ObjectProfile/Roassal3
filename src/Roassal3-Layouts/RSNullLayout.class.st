"
TODO
"
Class {
	#name : #RSNullLayout,
	#superclass : #RSLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSNullLayout >> doExecute: elements [
	elements do: [ :e | e translateTo: 0 @ 0 ]
]
