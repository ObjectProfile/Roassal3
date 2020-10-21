"
I have basic animation examples
"
Class {
	#name : #RSBasicAnimationExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
RSBasicAnimationExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| c b |
	c := RSCanvas new.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c addShape: b.
	
	c newAnimation 
		easing: RSEasing bounce;
		from: -100@ -100;
		to: 100@100;
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
		when:RSMouseClick
		do: [ c animations do: #pause ];
		when: RSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c clearBackground: false.
	^ c
]

{ #category : #examples }
RSBasicAnimationExamples >> example02Sequential [
	<script: 'self new example02Sequential open'>
	| c b animation |
	c := RSCanvas new.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c addShape: b.
	
	animation := c animationFrom: { 
		(c transitionAnimation
			from: -100@ -200;
			to: 100@130;
			on: b set: #position:).
		(c transitionAnimation
			from: Color red;
			to: Color blue;
			on: b set: #color:).
		(c transitionAnimation 
			from: 0;
			to: 10;
			on: b border set: 'width:')
	}.
	animation
		loops: 2.
	
	c 
		when:RSMouseClick
		do: [ c animations do: #pause ];
		when: RSMouseDoubleClick 
		do: [ c animations do: #continue ].
	^ c
]

{ #category : #examples }
RSBasicAnimationExamples >> example03Ramp [
	<script: 'self new example03Ramp open'>
	| c b |
	c := RSCanvas new.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c addShape: b.
	
	c newAnimation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)};
		on: b set: #position:.
	
	c 
		when:RSMouseClick
		do: [ c animations do: #pause ];
		when: RSMouseDoubleClick 
		do: [ c animations do: #continue ].
	^ c
]

{ #category : #lines }
RSBasicAnimationExamples >> example04DashAnimation [
	<script: 'self new example04DashAnimation open'>

	| c box paint form border animation |
	c := RSCanvas new.
	form := self iconNamed: #eyedropper.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	border := RSBorder new
		color: Color purple;
		dashArray: #(4).
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
	box when: RSMouseClick do: [ :a |
		animation isPaused 
			ifTrue: [ animation continue ]
			ifFalse: [ animation pause ] ].
	^ c

]

{ #category : #lines }
RSBasicAnimationExamples >> example05LoopEvent [
	<script: 'self new example05LoopEvent open'>
	| canvas box |
	canvas := RSCanvas new.
	canvas clearBackground: false.
	box := RSComposite new
		add: (RSLabel new text: '0');
		adjustToChildren;
		yourself.
	(canvas animationFrom: { 
		canvas transitionAnimation })
		loops: 3;
		when: RSAnimationLoopEvent do: [ :evt | 
			box children first text: evt currentLoop.
			box position: 0 @ evt currentLoop * 50.
			canvas signalUpdate].
	canvas add: box.

	^ canvas
]

{ #category : #lines }
RSBasicAnimationExamples >> example06Parallel [
	<script: 'self new example06Parallel open'>
	| canvas box1 box2 animation updateWithAngle |
	canvas := RSCanvas new.
	canvas clearBackground: false.
	box1 := RSBox new size: 50; color: (Color red alpha: 0.02).
	box2 := RSBox new size: 50; color: (Color blue alpha: 0.02).
	updateWithAngle := [ :ang :box | | p |
		p := ang degreesToRadians.
		p := p cos @ p sin negated * 100.
		box position: p.
		].
	animation := canvas parallelAnimation.
	animation addAll: { 
		canvas transitionAnimation
			from: 90;
			to: -90;
			onStepDo: updateWithAngle with: box1.
		canvas transitionAnimation
			from: 90;
			to: 270;
			onStepDo: updateWithAngle with: box2.
		}.
	(canvas animationFrom: { 
		canvas transitionAnimation
			from: 0@100;
			to: 0@ -100;
			onStepDo: [ :p | box1 position: p. box2 position: p].
		animation
	}) loops: 2.
	canvas add: box1; add: box2.
	canvas when: RSMouseClick do: [ :evt | canvas animations do: #toggle ].
	^ canvas
]

{ #category : #lines }
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
			c signalUpdate.
			].
	^ c
]

{ #category : #lines }
RSBasicAnimationExamples >> example08PopupAndMarkers [
	<script: 'self new example08PopupAndMarkers open'>
	| line marker canvas |
	line := RSLine new.
	line startPoint: 300@300; endPoint: 500@300.
	marker := RSShapeFactory star size: 40.
	line markerEnd: marker.
	line @ RSPopup new.
	line model: 'foo'.
	canvas := RSCanvas new add: line; yourself.
	canvas zoomToFit.
	^ canvas
]
