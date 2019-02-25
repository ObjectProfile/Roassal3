"
I am an edge builder
"
Class {
	#name : #RSEdgeBuilder,
	#superclass : #RSAbstractModelBuilder,
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

{ #category : #accessing }
RSEdgeBuilder >> edgeClass: aClass [
	self 
		elementClass: RSEdge;
		innerClass: aClass.
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edgeFrom: fromObject to: toObject [
	^ self edgeFrom: fromObject to: toObject index: nil
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edgeFrom: fromObject to: toObject index: index [
	| ed |
	ed := self basicElementOn: fromObject ->toObject index: index.
	ed 
		from: fromObject;
		to: toObject.
	^ ed
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> elementOn: model index: index [
	self error: 'You cannot send #elementOn: to a line. Create an edge using #edgeFrom:to:'
]
