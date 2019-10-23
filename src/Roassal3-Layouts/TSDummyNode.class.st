"
A RODummyNode is used by the sugiyama layout
"
Class {
	#name : #TSDummyNode,
	#superclass : #TSObject,
	#instVars : [
		'edge'
	],
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #'instance creation' }
TSDummyNode class >> on: anEdge slot: anIndex [
	
	^(self new)
		edge: anEdge;
		slot: anIndex;
		yourself
]

{ #category : #accessing }
TSDummyNode >> edge [
	
	^edge
]

{ #category : #accessing }
TSDummyNode >> edge: anEdge [
	
	edge := anEdge
]

{ #category : #accessing }
TSDummyNode >> extent [
	^ self height @ self width
]

{ #category : #accessing }
TSDummyNode >> height [
	
	^0
]

{ #category : #accessing }
TSDummyNode >> position [
	^ 0 @ 0
]

{ #category : #accessing }
TSDummyNode >> signalUpdate [
	"do nothing"
]

{ #category : #accessing }
TSDummyNode >> slot: anIndex [
	
]

{ #category : #accessing }
TSDummyNode >> translateBy: apoint [
	"do nothing"
]

{ #category : #accessing }
TSDummyNode >> translateTo: aPoint [
	
	"edge index: index point: aPoint"
]

{ #category : #accessing }
TSDummyNode >> width [
	
	^0
]
