"
I have examples for animation
"
Class {
	#name : #AnimationExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
AnimationExamples >> example01 [ 
	<script: 'self new example01'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation 
		easing: TSEasing bounce;
		from: -100@ -100;
		to: 100@100;
		on: b set: #position:.
	c animation 
		from: Color red;
		to: Color blue;
		on: b set: #color:.
	c animation 
		from: 0;
		to: 10;
		on: b border set: 'width:'.
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c clearBackground: false.
	c open.
]

{ #category : #examples }
AnimationExamples >> example02 [
	<script: 'self new example02'>
	| c b animation |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	animation := c animationFrom: { 
		(c tAnimation
			from: -100@ -200;
			to: 100@130;
			on: b set: #position:).
		(c tAnimation
			from: Color red;
			to: Color blue;
			on: b set: #color:).
		(c tAnimation 
			from: 0;
			to: 10;
			on: b border set: 'width:')
	}.
	animation
		loops: 2.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

{ #category : #examples }
AnimationExamples >> example03 [
	<script: 'self new example03'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)};
		on: b set: #position:.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

{ #category : #examples }
AnimationExamples >> example04 [
	<script: 'self new example04'>
	| v elements extent points frameCount |
	v := RSView new.
	v color: Color black.
	extent := 1920@1080.
	points := (0 to: extent x by: 50) flatCollect: [ :x |
		(0 to: extent y by: 50) collect: [ :y | (x@y)- (extent/2) ] ].
	elements := RSShapeBuilder box
		extent: 140@40;
		color: Color white;
		border: (TSBorder new
			color: (Color gray alpha: 0.5) ) ;
		elementsOn: points.
	v addAll: elements.
	frameCount := 0.
	v animation repeat;
		onStepDo: [ :t |
			elements do: [ :e | 
				e matrix 
					loadIdentity;
					translateBy: e model;
					rotateByRadians: (e model x + e model y + frameCount) degreesToRadians * 1.95  ].
			v signalUpdate.
			frameCount := frameCount + 1. ].
	v open.
]

{ #category : #examples }
AnimationExamples >> example05 [
	<script: 'self new example05'>
	| v extent r  elements position shape alpha update updateLine lineX line |
	v := RSView new.
	r := SharedRandom globalGenerator.

	shape := RSShapeBuilder box
		paint: nil;
		border: (TSBorder new
			width: 4).
		
	elements := shape elementsOn: ((1 to: 12) collect: [:i | r next ]).
	v addAll: elements.
	lineX := 0.
	line := RSEdgeBuilder line
		color: Color red;
		width: 8;
		from: 1@0; to: 0@0; edge.
	v add: line. 
	position := nil.
	updateLine := [
		line 
			from: lineX@position from y;
			to: lineX@position to y;
			update. ].
	v when: TSMouseMove do: [ :ev | 
		lineX := ev position x.
		updateLine value ].
	update := [ 
		extent := v extent.
		position := TSScale linear
			range: { extent / 2 negated. extent /2 }.
		updateLine value.
		elements do: [ :e | e translateTo: (position scale: r next@ r next) ].
	].
	update value.
	v when: TSResizeCanvasEvent do: update.
	
	RSNormalizer size
		from: 30;
		to: 100;
		elements: elements;
		normalize: #yourself.
	"shadow"
	alpha := TSScale linear domain: #(1 4); range: #(0.4 0.05).
	elements do: [ :e | | ant |
		ant := e.
		1 to: 4 do: [:i | | s |
			s := shape
				position: e position;
				extent: e extent;
				border: (TSBorder new
					width: 5;
					color: (e border color alpha: (alpha scale: i)));
				elementOn: i.
			ant when: TSTranslationEvent do: [ :evt | 
				s translateTo: evt position ].
			ant := s.
			v add: s
			] ] .
	"animation"
	v animation repeat; 
		onStepDo: [ :t | 
			elements do: [ :e |
				| delta newX |
				delta := e attributes at: #delta ifAbsentPut: [ 5 ].
				newX := e position x + delta.
				(newX 
					between: position from x 
					and: position to x) ifFalse: [ 
					delta := delta negated.
					newX := e position x + delta.
					 ].
				e translateTo: newX@e position y.
				e attributes at: #delta put: delta
				].
			v elements do: [ :e | | cls |
				cls := e position x > lineX 
					ifTrue: [ TSEllipse ]
					ifFalse: [ TSBox ].
				e trachelShape: cls new.
				 ].
			v signalUpdate ].
	"m := v morph.
	PolymorphSystemSettings setDesktopLogoWith: m.
	m position: 0@World menubar height.
	m extent: World extent- (0@World menubar height)."
	v open.
]
