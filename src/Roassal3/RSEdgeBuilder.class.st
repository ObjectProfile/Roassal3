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
RSEdgeBuilder class >> bezier [
	^ self new edgeClass: TSBezier
]

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
		from: (fromObject rsValue: model) ;
		to: (toObject rsValue: model).
	^ ed
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> edgesOn: aCollection [
	| g |
	g := TSGroup new: aCollection size.
	aCollection doWithIndex: [ :obj : index |
		g add: (self edgeOn: obj index: index) ].
	^ g
]

{ #category : #'public - accessing' }
RSEdgeBuilder >> elementOn: model index: index [
	"You cannot send #elementOn: to a line. Create an edge using #edgeFrom:to:"
	self shouldNotImplement
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

{ #category : #accessing }
RSEdgeBuilder >> updateElement: edge [
	super updateElement: edge.
	edge update.
]
