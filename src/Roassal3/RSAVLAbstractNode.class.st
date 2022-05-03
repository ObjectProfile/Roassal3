"
Abstract class to use nil pattern
"
Class {
	#name : #RSAVLAbstractNode,
	#superclass : #Object,
	#category : #'Roassal3-Rendering'
}

{ #category : #accessing }
RSAVLAbstractNode >> children [
	^ {  }
]

{ #category : #enumerating }
RSAVLAbstractNode >> do: aBlock [
]

{ #category : #accessing }
RSAVLAbstractNode >> height [
	^ 0
]

{ #category : #testing }
RSAVLAbstractNode >> isBalanced [
	^ true
]

{ #category : #testing }
RSAVLAbstractNode >> isNilNode [
	^ false
]

{ #category : #accessing }
RSAVLAbstractNode >> withAllChildren: aCollection [ 
]
