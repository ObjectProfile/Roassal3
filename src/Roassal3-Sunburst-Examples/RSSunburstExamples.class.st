"
I have basic examples for sunburst
"
Class {
	#name : #RSSunburstExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Sunburst-Examples'
}

{ #category : #examples }
RSSunburstExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb explore: String using: #subclasses.
	sb canvas @ RSCanvasController.
	^ sb
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
	sb canvas @ RSCanvasController.
	^ sb
]

{ #category : #examples }
RSSunburstExamples >> example03ConstantStrategy [
	<script: 'self new example03ConstantStrategy open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb constantWidthStrategy arcWidth: 25.
	sb explore: Collection using:  #subclasses.
	sb canvas @ RSCanvasController.
	^ sb
]

{ #category : #examples }
RSSunburstExamples >> example04Edges [
	<script: 'self new example04Edges open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb explore: Collection using:  #subclasses.
	sb canvas @ RSCanvasController.
	sb build.
	RSLineBuilder arrowedLine
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
	RSLineBuilder sunburstBezier
		width: 2;
		color: Color black;
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
		from: Color veryLightGray translucent;
		to: Color gray;
		shapes: (sb shapes reject: #isSLeaf);
		normalize: #linesOfCode.
	RSNormalizer color
		from: (Color colorFrom: '9B366C');
		to: (Color colorFrom: '563A63');
		shapes: (sb shapes select: #isSLeaf);
		normalize: #linesOfCode.
	composite adjustToChildren.
	RSLineBuilder sunburstBezier
		width: 1;
		markerEnd:
			(RSEllipse new
				size: 10;
				color: Color black;
				yourself);
		canvas: composite;
		connectFrom: #superclass.
	canvas := RSCanvas new.
	controller := RSCanvasController new.
	(controller interactions at: RSDraggableCanvasInteraction) right.
	canvas @ controller.
	canvas add: composite.
	composite @ RSRotatedInteraction.
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

	 sb shapes 
		when: RSMouseEnter do: [ :evt | 
			| path |
			path := (interaction pathFor: evt shape) reverse.
			path := String streamContents: [:s | 
				path do: [ :node | s << node model asString ] separatedBy: [ s << '>>' ] ].
			label text: path; signalUpdate.
			label position: label extent / 2 ];
		when: RSMouseLeave do: [ :evt |
			label text: '' ].
	sb shapes @ interaction.
	sb canvas add: label.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example08SunburstExplorer [
	<script: 'self new example08SunburstExplorer open'>
	| sb canvas newData color newAnimation first interpolate label |
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	color := NSScale category20c.
	newData := nil.
	newAnimation := [ :from :to |
		canvas newAnimation
			"duration: 500 milliSeconds;"
			easing: RSEasing bounceOut;
			from: from;
			to: to;
			yourself ].
	
	interpolate := [ :oldShape :newShape :target |
		(newAnimation 
			value: oldShape alphaAngle
			value: newShape alphaAngle)
			onStepDo: [ :t | target alphaAngle: t. canvas signalUpdate ].
		(newAnimation 
			value: oldShape betaAngle
			value: newShape betaAngle)
			onStepDo: [ :t | target betaAngle: t ].
		(newAnimation 
			value: oldShape innerRadius
			value: newShape innerRadius)
			onStepDo: [ :t | target innerRadius: t ].
		(newAnimation 
			value: oldShape externalRadius
			value: newShape externalRadius)
			onStepDo: [ :t | target externalRadius: t ];
			yourself ].
		
	sb := RSSunburstBuilder new.
	sb 
		container: canvas;
		sliceColor: [:shape | color scale: shape model category ].
	sb sliceShape
		withBorder.
	canvas addShape: (label := RSLabel new 
		text: '';
		isFixed: true;
		yourself).	
	newData := [ :class | | lastShapes newShapes oshape |
		lastShapes := canvas shapes copy.
		sb explore: class using:  #subclasses.
		sb build.
		label text: class name.
		
		newShapes := sb shapes.
		first := newShapes first.
		first when: RSMouseClick do: [ :evt | | cls |
			cls := evt shape model superclass.
			cls = Object ifFalse: [ newData value: cls ] ].
		(newShapes allButFirst reject: #isSLeaf)
			when: RSMouseClick do: [ :evt | newData value: evt shape model ].
		
		newShapes size < lastShapes size ifTrue: [ 
			newShapes do: [:new | | old |
				old := lastShapes shapeFromModel: new model.
				old remove.
				interpolate value: old value: new value: new].
			oshape := lastShapes shapeFromModel: class.
			lastShapes do: [ :old | | new |
				new := RSPieSlice new.
				oshape betaAngle < old betaAngle 
					ifTrue: [ new alphaAngle: 360; betaAngle: 360 ].
				old depth = 1 ifTrue: [ new alphaAngle: 0; betaAngle: 360 ].
				(interpolate value: old value: new value: old) 
					when: RSAnimationLoopEvent do: [ old remove ].
				 ].
		] ifFalse: [ 
			oshape := lastShapes 
				ifEmpty: [ RSPieSlice new ] 
				ifNotEmpty: [ newShapes shapeFromModel: lastShapes first model. ].
			newShapes do: [ :new | | old |
				old := lastShapes shapeFromModel: new model.
				old ifNil: [ 
					old := RSPieSlice new.
					oshape betaAngle < new betaAngle
						ifTrue: [ old alphaAngle: 360; betaAngle: 360. ]
						ifFalse: [ old alphaAngle: 0; betaAngle: 0.]
					 ].
				new depth = 1 ifTrue: [ old alphaAngle: 0; betaAngle: 360 ].
				old remove.
				interpolate value: old value: new value: new. ].
		]
	].
	canvas 
		when: RSExtentChangedEvent 
		do: [ label position: (canvas extent x / 2) @ (canvas extent y - label height) ].
			
	newData value: Collection.
	^ canvas.
]
