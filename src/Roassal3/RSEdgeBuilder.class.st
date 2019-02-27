"
I am an edge builder
"
Class {
	#name : #RSEdgeBuilder,
	#superclass : #RSAbstractShapeBuilder,
	#instVars : [
		'fromObject',
		'toObject'
	],
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSEdgeBuilder class >> line [
	^ self new edgeClass: TSLine
]

{ #category : #'instance creation' }
RSEdgeBuilder class >> linePath [
	^ self new edgeClass: TSSVGPathLine
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edge [
	^ self edgeOn: fromObject -> toObject
]

{ #category : #accessing }
RSEdgeBuilder >> edgeClass: aClass [
	self 
		elementClass: RSEdge;
		innerClass: aClass.
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edgeOn: model [
	^ self edgeOn: model index: nil
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edgeOn: model index: index [
	| ed |
	ed := self basicElementOn: model index: index.
	ed 
		from: fromObject;
		to: toObject.
	^ ed
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> elementOn: model index: index [
	self error: 'You cannot send #elementOn: to a line. Create an edge using #edgeFrom:to:'
]

{ #category : #accessing }
RSEdgeBuilder >> from [
	^ fromObject
]

{ #category : #accessing }
RSEdgeBuilder >> from: anObject [
	fromObject := anObject.
]

{ #category : #accessing }
RSEdgeBuilder >> to [
	^ toObject
]

{ #category : #accessing }
RSEdgeBuilder >> to: anObject [
	toObject := anObject.
]
