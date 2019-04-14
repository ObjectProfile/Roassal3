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

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> arrowedLine [
	| marker inst |
	marker := TSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		paint: nil;
		border: (TSBorder new).
	inst := self line.
	inst markerEnd: marker.
	^ inst.
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> bezier [
	^ self new edgeClass: TSBezier
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> bimetricLine [
	^ self new edgeClass: TSBimetricLine
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> horizontalBezier [
	^ self horizontalLine: self bezier.
	
]

{ #category : #helpers }
RSSingleEdgeBuilder class >> horizontalLine: inst [
	inst controlPoints: [ [:from :to | 
		| mid |
		mid := (from + to)/2.
		Array 
			with: from
			with: mid x @ from y
			with: mid x @ to y
			with: to ] ].
	^ inst
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> line [
	^ self new edgeClass: TSLine
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> linePath [
	^ self new edgeClass: TSSVGPathLine
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> orthoHorizontal [
	^ self horizontalLine: self polyline.
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> orthoVertical [
	^ self verticalLine: self polyline.
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> polyline [
	^ self new edgeClass: TSPolyline
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> verticalBezier [
	^ self verticalLine: self bezier.
	
]

{ #category : #helpers }
RSSingleEdgeBuilder class >> verticalLine: inst [
	inst controlPoints: [ [:from :to | 
		| mid |
		mid := (from + to)/2.
		Array
			with: from
			with: from x @ mid y
			with: to x @ mid y
			with: to ] ].
	^ inst
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
		to: (toObject rsValue: model);
		update.
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

{ #category : #'public - attach point' }
RSSingleEdgeBuilder >> withBorderAttachPoint [
	self attachPoint: RSBorderAttachPoint new.
]

{ #category : #'public - attach point' }
RSSingleEdgeBuilder >> withCenteredAttachPoint [
	self attachPoint: RSAttachPoint new.
]

{ #category : #'public - attach point' }
RSSingleEdgeBuilder >> withHorizontalAttachPoint [
	self attachPoint: RSHorizontalAttachPoint new.
]

{ #category : #'public - attach point' }
RSSingleEdgeBuilder >> withVerticallAttachPoint [
	self attachPoint: RSVerticalAttachPoint new.
]
