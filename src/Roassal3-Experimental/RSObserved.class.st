"
TODO
"
Class {
	#name : #RSObserved,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'mousePoint',
		'random'
	],
	#category : #'Roassal3-Experimental-Animations'
}

{ #category : #running }
RSObserved >> blink: brothers [
	| brother key eyeLeft eyeRight p1 p2 |
	random next > 0.05 ifTrue: [ ^ self ].
	brother := brothers atRandom.
	key := #blinking.
	(brother hasProperty: key) ifTrue: [ ^ self ].
	brother propertyAt: key put: 1.
	eyeLeft := brother children second.
	eyeRight := brother children third.
	p1 := eyeLeft position.
	p2 := eyeRight position.
	
	canvas newAnimation
		scale: (NSScale linear
			domain: {0. 0.5. 1};
			range: {1. 0.05. 1});
		duration: 500 milliSeconds;
		onStepDo: [ :t |
			eyeLeft matrix 
				loadIdentity;
				scaleBy: 1@ t;
				translation: p1.
			eyeRight matrix 
				loadIdentity;
				scaleBy: 1@ t;
				translation: p2.
			 ];
		when: RSAnimationEndEvent do: [ brother removeKey: key ]
	
]

{ #category : #running }
RSObserved >> createBrother [
	| head leftEye rightEye |
	head := RSBox new
		color: Color black;
		cornerRadius: 30;
		extent: 120@100;
		yourself.
	leftEye := self createEye.
	rightEye := self createEye.
	leftEye position: -20@0.
	rightEye position: 20@0.
	^ { head. leftEye. rightEye } asGroup asShape
]

{ #category : #running }
RSObserved >> createEye [
	| globe iris irisa irisb eye |
	globe := RSEllipse new
		size: 30;
		color: Color white;
		yourself.
		
	irisa := RSEllipse new
		size: 15;
		color: Color black;
		yourself.
	irisb := RSEllipse new
		size: 4;
		color: Color white;
		yourself.
	iris := { irisa. irisb } asGroup asShape.
	eye := { globe. iris } asGroup asShape.
	mousePoint when: RSPositionChangedEvent do: [ :evt | | angle |
		angle := (mousePoint position - (eye parent position+eye position) ) angle.
		iris translateTo: (angle cos @ angle sin) * 10.
		].
	^ eye
		
]

{ #category : #running }
RSObserved >> run [
	<script: 'self new run'>
	| brothers layout mock |
	canvas := RSCanvas new.
	mousePoint := RSBox new size: 10.
	random := Random new.
	brothers := (1 to: 20) collect: [ :t | self createBrother ] as: RSGroup.
	layout := RSForceBasedLayout new
		charge: -400;
		gravity: 0.05;
		strength: 0.2;
		nodes: brothers, {mousePoint};
		start;
		alpha: 0.5;
		yourself.
	mock :=layout mockElementAt: mousePoint.
	canvas when: RSMouseClick do: [ canvas animations do: #toggle ].
	mock isFixed: true.
	mock fixPosition: 0@0.
	canvas addAll: brothers.
	canvas newAnimation repeat onStepDo: [ :t | layout step. self blink: brothers ].
	canvas when: RSMouseMove do: [ :evt | 
		mock fixPosition: evt position.
		mousePoint translateTo: evt position.].
	canvas color: Color transparent.
	canvas open
		position: 0@30;
		color: Color transparent;
		setLabel: 'Big brothers are watching you :V';
		extent: 800@800.
]
