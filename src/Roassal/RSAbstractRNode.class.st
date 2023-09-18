"
based on nil pattern
"
Class {
	#name : #RSAbstractRNode,
	#superclass : #RSObject,
	#category : #'Roassal3-Rendering'
}

{ #category : #visiting }
RSAbstractRNode >> accept: visitor [
]

{ #category : #adding }
RSAbstractRNode >> addChild: newObject [
	^ self subclassResponsibility
]

{ #category : #public }
RSAbstractRNode >> computeHeight [
	^ 0
]

{ #category : #enumerating }
RSAbstractRNode >> do: aBlock [
]

{ #category : #accessing }
RSAbstractRNode >> height [
	^ 0
]

{ #category : #testing }
RSAbstractRNode >> isBalanced [
	^ true
]

{ #category : #testing }
RSAbstractRNode >> isEmpty [
	^ true
]

{ #category : #testing }
RSAbstractRNode >> isNilNode [
	^ false
]

{ #category : #testing }
RSAbstractRNode >> isTotalBalanced [
	^ true
]

{ #category : #'finding/searching' }
RSAbstractRNode >> nodesIntersetcsRectangle: aRectangle list: list [
]

{ #category : #'finding/searching' }
RSAbstractRNode >> nodesWithPoint: aPoint list: list [
]

{ #category : #accessing }
RSAbstractRNode >> rectangle [
	^ 0@0 corner: 0@0
]

{ #category : #'finding/searching' }
RSAbstractRNode >> searchPath: anObject [
	^ #()
]

{ #category : #'accessing - children' }
RSAbstractRNode >> withAllChildren [
	^ #()
]
