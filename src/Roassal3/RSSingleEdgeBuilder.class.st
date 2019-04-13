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
"Here is an example on how to use it.

| view e1 e2 box l |
	view := RSView new.
	box := RSShapeBuilder box 
		size: 100;
		draggable.
	e1 := box element.
	e1 color: Color blue.
	e2 := box element.
	e2 translateTo: 400@0.
	l := RSSingleEdgeBuilder bimetricLine
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: e1;
		to: e2;
		edge.
	view addAll: { e1. e2. l}.
	view @ RSControlsView. 
	view open
"
	^ self new edgeClass: TSBimetricLine
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
	^ self orthoHorizontalBalanceTo: 0.5
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> orthoHorizontalBalanceTo: balance [
	| inst |
	inst := self polyline.
	inst controlPoints: [ [:from :to | 
		| midx |
		midx := to x * balance + (from x * (1 - balance)).
		Array
			with: from
			with: midx @ from y
			with: midx @ to y
			with: to ] ].
	^ inst
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> orthoVertical [

"Here is an example


v := RSView new.

classes := Collection withAllSubclasses.
boxes := RSShapeBuilder box
				width: [ :cls | cls instVarNames size * 5 max: 5 ];
				height: [ :cls | cls numberOfMethods max: 5 ];
				elementsOn: classes.
boxes @ RSDraggable.
v addAll: boxes.

RSEdgeBuilder orthoVertical
	view: v;
	attachPoint: RSVerticalAttachPoint new;
	elements: boxes;
	connectFrom: #superclass.

RSTreeLayout on: v elements.
v @ RSControlsView.
v open
"

	^ self orthoVerticalBalanceTo: 0.5
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> orthoVerticalBalanceTo: balance [
	| inst |
	inst := self polyline.
	inst controlPoints: [ [:from :to | 
		| midy |
		midy := to y * balance + (from y * (1 - balance)).
		Array
			with: from
			with: from x @ midy
			with: to x @ midy
			with: to ] ].
	^ inst
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> polyline [
	^ self new edgeClass: TSPolyline
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
