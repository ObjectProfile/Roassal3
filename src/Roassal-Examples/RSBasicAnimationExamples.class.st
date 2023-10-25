"
I have basic animation examples
"
Class {
	#name : 'RSBasicAnimationExamples',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Examples-Basic',
	#package : 'Roassal-Examples',
	#tag : 'Basic'
}

{ #category : 'examples' }
RSBasicAnimationExamples >> example01Basic [

	<script: 'self new example01Basic open'>
	| c b |
	c := RSCanvas new.
	b := RSBox new
		     extent: 100 @ 100;
		     border: (RSBorder new color: 'black').
	c addShape: b.

	c newAnimation
		easing: RSEasingInterpolator bounce;
		from: -100 @ -100;
		to: 100 @ 100;
		on: b set: #position:.
	c newAnimation
		from: Color red;
		to: Color blue;
		on: b set: #color:.
	c newAnimation
		from: 0;
		to: 10;
		on: b border set: 'width:'.
	c
		when: RSMouseClick do: [ c animations do: #pause ] for: self;
		when: RSMouseDoubleClick
		do: [ c animations do: #continue ]
		for: self.
	c shouldClearBackground: false.
	^ c
]

{ #category : 'examples' }
RSBasicAnimationExamples >> example02Sequential [

	<script: 'self new example02Sequential open'>
	| c b animation |
	c := RSCanvas new.
	b := RSBox new
		     extent: 100 @ 100;
		     withBorder.
	c addShape: b.

	animation := c animationFrom: {
			             (c transitionAnimation
				              from: -100 @ -200;
				              to: 100 @ 130;
				              on: b set: #position:).
			             (c transitionAnimation
				              from: Color red;
				              to: Color blue;
				              on: b set: #color:).
			             (c transitionAnimation
				              from: 0;
				              to: 10;
				              on: b border set: 'width:') }.
	animation loops: 2.

	c
		when: RSMouseClick do: [ c animations do: #pause ] for: self;
		when: RSMouseDoubleClick
		do: [ c animations do: #continue ]
		for: self.
	^ c
]

{ #category : 'examples' }
RSBasicAnimationExamples >> example03Ramp [

	<script: 'self new example03Ramp open'>
	| c b |
	c := RSCanvas new.
	b := RSBox new
		     extent: 100 @ 100;
		     withBorder.
	c addShape: b.

	c newAnimation
		ramp: {
				(0 -> (0 @ 0)).
				(0.25 -> (200 @ 180)).
				(0.75 -> (-200 @ -80)).
				(1 -> (200 @ 0)) };
		on: b set: #position:.

	c
		when: RSMouseClick do: [ c animations do: #pause ] for: self;
		when: RSMouseDoubleClick
		do: [ c animations do: #continue ]
		for: self.
	^ c
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example04DashAnimation [

	<script: 'self new example04DashAnimation open'>
	| c box paint form border animation |
	c := RSCanvas new.
	form := self iconNamed: #eyedropper.
	paint := AthensCairoPatternSurfacePaint createForSurface:
		(AthensCairoSurface fromForm: form).
	paint origin: (form extent / 2) negated.
	border := RSBorder new
		color: Color purple;
		dashArray: #( 4 ).
	box := RSBox new
		paint: paint;
		extent: form extent;
		border: border;
		scaleBy: 3.

	c addShape: box.

	animation := c newAnimation
		repeat;
		from: 0;
		to: 8;
		on: border set: #dashOffset:.
	box
		when: RSMouseClick
		do: [ :a |
			animation isPaused
				ifTrue: [ animation continue ]
				ifFalse: [ animation pause ] ]
		for: self.
	^ c
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example05LoopEvent [

	<script: 'self new example05LoopEvent open'>
	| canvas box |
	canvas := RSCanvas new.
	canvas shouldClearBackground: false.
	box := RSComposite new
		       add: (RSLabel new text: '0');
		       adjustToChildren;
		       yourself.
	(canvas animationFrom: { canvas transitionAnimation })
		loops: 3;
		when: RSAnimationLoopEvent do: [ :evt |
			box children first text: evt currentLoop.
			box position: 0 @ evt currentLoop * 50.
			canvas signalUpdate ]
		for: self.
	canvas add: box.

	^ canvas
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example06Parallel [

	<script: 'self new example06Parallel open'>
	| canvas box1 box2 animation updateWithAngle |
	canvas := RSCanvas new.
	canvas shouldClearBackground: false.
	box1 := RSBox new
		        size: 50;
		        color: (Color red alpha: 0.02).
	box2 := RSBox new
		        size: 50;
		        color: (Color blue alpha: 0.02).
	updateWithAngle := [ :ang :box |
	                   | p |
	                   p := ang degreesToRadians.
	                   p := p cos @ p sin negated * 100.
	                   box position: p ].
	animation := canvas parallelAnimation.
	animation addAll: {
			(canvas transitionAnimation
				 from: 90;
				 to: -90;
				 onStepDo: updateWithAngle with: box1).
			(canvas transitionAnimation
				 from: 90;
				 to: 270;
				 onStepDo: updateWithAngle with: box2) }.
	(canvas animationFrom: {
			 (canvas transitionAnimation
				  from: 0 @ 100;
				  to: 0 @ -100;
				  onStepDo: [ :p |
					  box1 position: p.
					  box2 position: p ]).
			 animation }) loops: 2.
	canvas
		add: box1;
		add: box2.
	canvas
		when: RSMouseClick
		do: [ :evt | canvas animations do: #toggle ]
		for: self.
	^ canvas
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example07CornerRadius [
	<script: 'self new example07CornerRadius open'>
	| c paint b from to |
	c := RSCanvas new.
	paint := LinearGradientPaint fromArray:
		{ 0->Color red.
		1->Color black }.
	paint start: -100 asPoint; stop: 100 asPoint.
	b := RSBox new
		size: 200;
		paint: paint;
		cornerRadius: 0;
		border: (RSBorder new width: 3).
	c add: b.
	from := RSCornerRadius new topLeft: 200; bottomRight: 200.
	to := RSCornerRadius new topRight: 200; bottomLeft: 200.
	c newAnimation
		repeat;
		duration: 4 seconds;
		scale: (NSScale linear
			domain: #(0 0.5 1);
			range: #(0 1 0));
		onStepDo: [:t |
			b cornerRadius: (from interpolateTo: to at: t).
			b signalUpdate.
			].
	^ c
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example08Markers [
	<script: 'self new example08Markers open'>
	| canvas line radius marker red |
	canvas := RSCanvas new.
	line := RSLine new.
	radius := 100.
	canvas add: line.
	marker := RSBox new size: 20; withBorder; noPaint; asMarker.
	line markerEnd: marker.
	canvas newAnimation
		duration: 20 seconds;
		repeat;
		from: 0;
		to: Float twoPi;
		onStepDo: [ :a | | b |
			b := a + Float pi.
			line startPoint: (a cos @ a sin) * radius.
			line endPoint: (b cos @ b sin )* radius ].
	canvas newAnimation
		duration: 20 seconds;
		repeat;
		from: 1;
		to: 0;
		onStepDo: [ :ratio | marker offsetRatio: ratio ].
	canvas newAnimation
		duration: 1 seconds;
		repeat;
		scale: (NSScale linear
			domain: #(0 0.5 1);
			range: #(-30 30 -30) );
		onStepDo: [ :offset | marker offset: offset asPoint ].

	red := RSLine new yourself.
	red marker: (RSBox new size: 5; asMarker).
	red color: Color red.
	canvas add: red.
	canvas newAnimation repeat;
		onStepDo: [
			| vector unit |
			vector := line endPoint - line startPoint.
			unit := vector / (vector r max: 1).
			red startPoint: line endPoint - (vector * marker offsetRatio).
			red endPoint: red startPoint - (unit * marker offset).
			 ].

	^ canvas
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example09Easing [
	<script: 'self new example09Easing open'>
	| canvas radius numberOfCircles circles innerRadius |
	numberOfCircles := 8.
	radius := 100.
	innerRadius := 30.

	circles := (1 to: numberOfCircles) collect: [ :each |
		RSCircle new radius: 0; withBorder; noPaint ].

	canvas := RSCanvas new.
	canvas host aaBest.
	canvas addAnimation: (RSSequentialAnimation new
		add: (RSTransitionAnimation new
			duration: 2 seconds;
			easing: RSEasingInterpolator elasticOut;
			onStepDo: [:t |
				circles doWithIndex: [ :circle :index |
					circle radius: t * radius.
					circle position: innerRadius * (index even asInteger * 2 -1) @ 0 ].
			];
			yourself);
		add: (RSTransitionAnimation new
			duration: 2 seconds;
			easing: RSEasingInterpolator backOut;
			onStepDo: [ :t |
				circles doWithIndex: [ :circle :index | | angle toAngle fromAngle |
					toAngle := (index - 1) /numberOfCircles * Float twoPi.
					fromAngle := Float pi * index even asInteger.
					angle := fromAngle interpolateTo: toAngle at: t.
					circle position: (angle cos @ (angle sin) ) * innerRadius.
				]
			];
			yourself);
		yourself
		).
	canvas addAll: circles.
	^ canvas
]

{ #category : 'lines' }
RSBasicAnimationExamples >> example10Scales [

	<script: 'self new example10Scales open'>
	| c data width scale numbers totalLine lineWidth currentLevelLine labelShape background triangle level icons accept |
	c := RSCanvas new.
	width := 250.
	lineWidth := 20.
	data := {
		        (5 -> #userFemale).
		        (15 -> #checkboxSelected).
		        (30 -> #komitter).
		        (60 -> #user).
		        (100 -> #smallScreenshot).
		        (150 -> #smallFullscreen).
		        (200 -> #github).
		        (500 -> #glamorousBug).
		        (750 -> #tools).
		        (1000 -> #komitterNewSlice) }.
	numbers := OrderedCollection with: 0.
	numbers addAll: (data collect: #key).
	scale := NSScale linear
		         domain: numbers;
		         range: (0 to: width count: data size + 1).

	totalLine := RSLine new
		             width: lineWidth;
		             color: Color veryVeryLightGray;
		             startPoint:
			             (scale scale: numbers min) @ lineWidth negated;
		             endPoint:
			             (scale scale: numbers max) @ lineWidth negated;
		             yourself.
	labelShape := RSLabel new
		              fontSize: 7;
		              bold;
		              color: Color white;
		              borderColor: Color black;
		              borderWidth: 0.3;
		              yourself.
	c add: totalLine.
	background := RSPolygon new
		              points: {
				              (-10 @ -10).
				              (10 @ -10).
				              (10 @ 10).
				              (-10 @ 10) };
		              color: Color veryLightGray;
		              borderColor: Color black;
		              yourself.
	triangle := RSPolygon new
		            points: {
				            (0 @ 0).
				            (0 @ 3).
				            (-3 @ 3) };
		            color: Color veryLightGray;
		            borderColor: Color black;
		            yourself.
	accept := RSBitmap newFrom: #glamorousAccept.
	RSLocation new
		orientation: 1 @ -1;
		top;
		right;
		move: triangle on: background;
		inner;
		top;
		right;
		move: accept on: background.
	icons := data
		         collect: [ :assoc |
			         | icon xpos label |
			         icon := RSBitmap newFrom: assoc value.
			         xpos := scale scale: assoc key.
			         icon := {
				                 background copy.
				                 icon } asShapeFor: assoc key.
			         icon addShape: triangle copy.
			         label := labelShape copy
				                  text: assoc key asString;
				                  yourself.
			         label position:
				         xpos - (label width / 2) - 0.5 @ lineWidth negated.
			         icon position: xpos - (icon width / 2) @ 5.
			         c addAll: {
					         label.
					         icon }.
			         icon ]
		         as: OrderedCollection.
	currentLevelLine := RSLine new
		                    color: Color green;
		                    width: lineWidth;
		                    startPoint: totalLine startPoint;
		                    endPoint: totalLine startPoint;
		                    yourself.
	c add: currentLevelLine.
	level := { labelShape copy } asShape
		         color: Color blue translucent;
		         borderColor: Color black;
		         yourself.
	c add: level.
	c newAnimation
		from: 0;
		to: 1000;
		easing: RSEasingInterpolator cubicIn;
		duration: 30 seconds;
		onStepDo: [ :t |
			| posx icon |
			posx := scale scale: t.
			currentLevelLine endPoint: posx @ lineWidth negated.
			level children first text: t asInteger asString.

			level
				adjustToChildren;
				padding: 3.
			level position: currentLevelLine endPoint.
			icon := icons first.
			icon model <= t asInteger ifTrue: [
				icon addShape: accept copy.
				icon shapes first color: Color black translucent.
				icons removeFirst ].
			c signalUpdate ].
	c
		when: RSExtentChangedEvent
		do: [
			c
				zoomToFit;
				signalUpdate ]
		for: self.
	^ c
]

{ #category : 'accessing' }
RSBasicAnimationExamples >> order [
	^ 10
]
