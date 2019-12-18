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
	sb sliceColor: [:shape | shape model subclasses isEmpty 
		ifTrue: [ Color purple ]
		ifFalse: [ Color lightGray ] ].
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
	sb strategy extent: 1000@1000.
	sb container: composite.
	sb sliceShape withBorder.
	sb explore: Collection using: #subclasses.
	sb build.
	RSNormalizer color
		from: Color veryLightGray trans;
		to: Color gray;
		shapes: (sb shapes reject: #isSLeaf);
		normalize: #linesOfCode.
	RSNormalizer color
		from: (Color colorFrom: '9B366C');
		to: (Color colorFrom: '563A63');
		shapes: (sb shapes select: #isSLeaf);
		normalize: #linesOfCode.
	composite adjustToChildren.
	RSEdgeBuilder sunburstBezier
		width: 1;
		markerEnd:
			(RSEllipse new
				size: 10;
				color: Color black;
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

{ #category : #examples }
RSSunburstExamples >> example07FadeInteraction [
	<script: 'self new example07FadeInteraction open'>
	| sb interaction label |
	sb := RSSunburstBuilder new.
	sb sliceShape
		withBorder.
	sb explore: Collection using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	interaction := RSSunburstFadeInteraction new
		builder: sb.
	label := RSLabel new.
	label text: 'fooo'.
	label isFixed: true.

	 sb shapes @ (RSHighlightable new
		attributeKey: 'text';
		when: RSHighlightEvent do: [ :evt | 
			| path |
			path := (interaction pathFor: evt shape) reverse.
			path := String streamContents: [:s | 
				path do: [ :node | s << node model asString ] separatedBy: [ s << '>>' ] ].
			label text: path; signalUpdate.
			label position: label extent / 2 ];
		when: RSUnHighlightEvent do: [ :evt |
			label text: '' ];
		yourself).
	sb shapes @ interaction.
	sb canvas add: label.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example08SunburstExplorer [
	<script: 'self new example08SunburstExplorer open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb sliceShape
		withBorder.
	sb explore: Collection using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	sb shapes @ RSSunburstFadeInteraction new.
	^ sb canvas
]
