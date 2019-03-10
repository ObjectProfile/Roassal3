"
I am an edge builder
"
Class {
	#name : #RSSingleEdgeBuilder,
	#superclass : #RSAbstractShapeBuilder,
	#instVars : [
		'fromObject',
		'toObject'
	],
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> bezier [
	^ self new edgeClass: TSBezier
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> line [
	^ self new edgeClass: TSLine
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> linePath [
	^ self new edgeClass: TSSVGPathLine
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> edge [
	^ self edgeOn: fromObject -> toObject
]

{ #category : #accessing }
RSSingleEdgeBuilder >> edgeClass: aClass [
	self 
		elementClass: RSEdge;
		innerClass: aClass.
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> edgeOn: model [
	^ self edgeOn: model index: nil
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> edgeOn: model index: index [
	| ed |
	ed := self basicElementOn: model index: index.
	ed 
		from: (fromObject rsValue: model) ;
		to: (toObject rsValue: model).
	^ ed
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> edgesOn: aCollection [
	| g |
	g := TSGroup new: aCollection size.
	aCollection doWithIndex: [ :obj : index |
		g add: (self edgeOn: obj index: index) ].
	^ g
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> elementOn: model index: index [
	"You cannot send #elementOn: to a line. Create an edge using #edgeFrom:to:"
	self shouldNotImplement
]

{ #category : #accessing }
RSSingleEdgeBuilder >> from [
	^ fromObject
]

{ #category : #accessing }
RSSingleEdgeBuilder >> from: anObject [
	fromObject := anObject.
]

{ #category : #accessing }
RSSingleEdgeBuilder >> to [
	^ toObject
]

{ #category : #accessing }
RSSingleEdgeBuilder >> to: anObject [
	toObject := anObject.
]

{ #category : #accessing }
RSSingleEdgeBuilder >> updateElement: edge [
	super updateElement: edge.
	edge update.
]
