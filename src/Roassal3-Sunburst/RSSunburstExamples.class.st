"
I have basic examples for sunburst
"
Class {
	#name : #RSSunburstExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Sunburst'
}

{ #category : #examples }
RSSunburstExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb explore: String using: #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example02MultipleRoots [
	<script: 'self new example02MultipleRoots open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb strategy hasCenter: false.
	sb sliceShape 
		withBorder;
		segmentSpacing: 1.
	sb from: { String. RSEvent. RSShape } using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example03ConstantStrategy [
	<script: 'self new example03ConstantStrategy open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb constantWidthStrategy arcWidth: 25.
	sb explore: Collection using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example04Edges [
	<script: 'self new example04Edges open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb explore: Collection using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	RSEdgeBuilder arrowedLine
		attachPoint: RSSunburstAttachPoint new;
		canvas: sb canvas;
		connectFrom: #superclass.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example05BezierEdges [
	<script: 'self new example05BezierEdges open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb sliceShape
		withBorder.
	sb color: [:shape | shape model subclasses 
		ifEmpty: [ Color purple ]
		ifNotEmpty: [ Color lightGray ] ].
	sb explore: Collection using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	RSEdgeBuilder sunburstBezier
		width: 2;
		markerEnd: (RSEllipse new 
			size: 10;
			color: Color white;
			withBorder;
			yourself);
		canvas: sb canvas;
		connectFrom: #superclass.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example06Rotation [
	<script: 'self new example06Rotation open'>
	| sb composite canvas controller |
	composite := RSComposite new.
	sb := RSSunburstBuilder new.
	sb container: composite.
	sb sliceShape
		withBorder.
	sb explore: Collection using:  #subclasses.
	sb build.
	composite adjustToChildren.
	RSEdgeBuilder sunburstBezier
		width: 2;
		markerEnd: (RSEllipse new 
			size: 10;
			color: Color white;
			withBorder;
			yourself);
		canvas: composite;
		connectFrom: #superclass.
	composite adjustToChildren.
	canvas := RSCanvas new.
	controller := RSCanvasController new.
	(controller interactions at: RSDraggableCanvas) right.
	canvas @ controller.
	canvas add: composite.
	composite @ RSRotated. 
	^ canvas
]
