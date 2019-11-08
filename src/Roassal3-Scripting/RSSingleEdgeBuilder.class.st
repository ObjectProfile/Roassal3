"
I am an edge builder
"
Class {
	#name : #RSSingleEdgeBuilder,
	#superclass : #RSAbstractModelBuilder,
	#instVars : [
		'fromObject',
		'toObject'
	],
	#category : #'Roassal3-Scripting-Builders'
}

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> arrowedLine [
	| marker inst |
	marker := RSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		paint: nil;
		border: (RSBorder new).
	inst := self line.
	inst markerEnd: marker.
	^ inst.
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> bezier [
	^ self new edgeClass: RSBezier
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
	^ self new edgeClass: RSBimetricLine
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> horizontalBezier [
"Here is an example

v := RSView new.

sb := RSShapeBuilder circle
			size: 20;
			elementsOn: (1 to: 20).
v addAll: sb.
sb @ RSDraggable.

eb := RSEdgeBuilder horizontalBezier
			view: v;
			connectFrom: 1 toAll: (2 to: 20).

RSCircleLayout on: sb.
v zoomToFit.
v open			
			"

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
	^ self new edgeClass: RSLine
]

{ #category : #'instance creation' }
RSSingleEdgeBuilder class >> linePath [
	^ self new edgeClass: RSSVGPathLine
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> multiBezier [
	^ RSMultiBezierEdgeBuilder linePath
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
	^ self new edgeClass: RSPolyline
]

{ #category : #'instance variations' }
RSSingleEdgeBuilder class >> verticalBezier [
"Here is an example:

v := RSView new.

sb := RSShapeBuilder circle
			size: 20;
			elementsOn: (1 to: 20).
v addAll: sb.
sb @ RSDraggable.

eb := RSEdgeBuilder verticalBezier
			view: v;
			connectFrom: 1 toAll: (2 to: 20).

RSCircleLayout on: sb.
v zoomToFit.
v open			
			"
	^ self verticalLine: self bezier.
	
]

{ #category : #helpers }
RSSingleEdgeBuilder class >> verticalLine: inst [
	inst 
		onElement;
		controlPoints: [ :ed | [:from :to | 
		| mid |
		mid := (from + to)/2.
		Array
			with: from
			with: from x @ mid y
			with: to x @ mid y
			with: to ] ];
		onModel.
	^ inst
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> edge [
	^ self edgeOn: fromObject model -> toObject model
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
	g := RSGroup new: aCollection size.
	aCollection doWithIndex: [ :obj : index |
		g add: (self edgeOn: obj index: index) ].
	^ g
]

{ #category : #'public - accessing' }
RSSingleEdgeBuilder >> elementOn: model index: index [
	"You cannot send #elementOn: to a line. Create an edge using #edgeFrom:to:"
	^ self edgeOn: model index: index
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
RSSingleEdgeBuilder >> withVerticalAttachPoint [
"
An example:

classesToVisualize := Collection withAllSubclasses.

v := RSView new.
boxes := RSShapeBuilder box
				width: [ :cls | cls instVarNames size * 3 max: 5 ];
				height: [ :cls | cls numberOfMethods max: 5 ];
				elementsOn: classesToVisualize.
v addAll: boxes.

RSEdgeBuilder orthoVertical 
	withVerticalAttachPoint
	view: v;
	connectFrom: #superclass.
	
RSTreeLayout on: boxes.

v @ RSControlsView.
v open			
"

	self attachPoint: RSVerticalAttachPoint new.
]
