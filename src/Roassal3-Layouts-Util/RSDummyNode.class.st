"
A RODummyNode is used by the sugiyama layout
"
Class {
	#name : #RSDummyNode,
	#superclass : #RSObject,
	#instVars : [
		'edge'
	],
	#category : #'Roassal3-Layouts-Util'
}

{ #category : #'instance creation' }
RSDummyNode class >> on: anEdge slot: anIndex [

	^(self new)
		edge: anEdge;
		slot: anIndex;
		yourself
]

{ #category : #accessing }
RSDummyNode >> edge [
	^ edge
]

{ #category : #accessing }
RSDummyNode >> edge: anEdge [
	edge := anEdge
]

{ #category : #accessing }
RSDummyNode >> extent [
	^ self height @ self width
]

{ #category : #accessing }
RSDummyNode >> height [
	^ 0
]

{ #category : #accessing }
RSDummyNode >> position [
	^ 0 @ 0
]

{ #category : #accessing }
RSDummyNode >> signalUpdate [
	"do nothing"
]

{ #category : #accessing }
RSDummyNode >> slot: anIndex [
]

{ #category : #accessing }
RSDummyNode >> translateBy: apoint [
	"do nothing"
]

{ #category : #accessing }
RSDummyNode >> translateTo: aPoint [
	"edge index: index point: aPoint"
]

{ #category : #accessing }
RSDummyNode >> width [
	^ 0
]
