"
TODO
"
Class {
	#name : #RSAmeba,
	#superclass : #Object,
	#instVars : [
		'shape',
		'polygon',
		'offset'
	],
	#category : #'Roassal3-Experimental-Alpharo'
}

{ #category : #updating }
RSAmeba >> blink [
	| leftEye rightEye p1 p2 |
	shape propertyAt: #blink put: 1.

	leftEye := shape children second.
	rightEye := shape children third.
	p1 := leftEye position.
	p2 := rightEye position.

	shape newAnimation
		scale: (NSScale linear
			domain: {0. 0.5. 1};
			range: {1. 0.05. 1});
		duration: 500 milliSeconds;
		onStepDo: [ :t |
			leftEye matrix
				loadIdentity;
				scaleBy: 1@ t;
				translation: p1.
			rightEye matrix
				loadIdentity;
				scaleBy: 1@ t;
				translation: p2.
			 ];
		when: RSAnimationEndEvent do: [ shape removeKey: #blink ]
]

{ #category : #accessing }
RSAmeba >> createBody [
	| body leftEye rightEye |
	polygon := RSShapeFactory square size: 100.
	polygon popup.
	polygon color: Color black.
	leftEye := self createEye.
	rightEye := self createEye.
	leftEye position: -15@0.
	rightEye position: 15@0.
	body := RSComposite new.
	body children: { polygon. leftEye. rightEye}.

	^ body
]

{ #category : #accessing }
RSAmeba >> createEye [
	| eye globe iris irisa irisb |
	globe := RSEllipse new extent: 25@20; color: Color white.
	irisa := RSEllipse new size: 10; color: Color black.
	irisb := RSEllipse new size: 4; color: Color white.
	iris := { irisa. irisb } asGroup asShape.
	eye := { globe. iris } asGroup asShape.
	irisb position: 3@ -3.
	^ eye
]

{ #category : #testing }
RSAmeba >> isBlinking [
	^ self shape hasProperty: #blink
]

{ #category : #accessing }
RSAmeba >> model: anObject [
	self shape children first model: anObject
]

{ #category : #accessing }
RSAmeba >> mousePosition [
	| position |
	position := self currentWorld currentHand position.
	position := position - self shape canvas morph positionInWorld.
	^ position
]

{ #category : #accessing }
RSAmeba >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
RSAmeba >> shape [
	^ shape ifNil: [ shape := self createBody ]
]

{ #category : #updating }
RSAmeba >> update: perlin [
	| angleInc offsetInc r points |
	angleInc := 1 / 10.
	offsetInc := 0.01.
	r := 100.
	points := (0 to: Float twoPi by: angleInc) collect: [:angle |
			| p n |
			p := angle sin @ angle cos.
			n := p * (3 @ 7) + offset.
			n := perlin noise: n x and: n y.
			p := p *  r * n.].
		polygon points: points.
		offset := offset + offsetInc.
	self updateEyes
]

{ #category : #updating }
RSAmeba >> updateEye: eye [
	| position angle iris eyepos dist |
	position := self mousePosition.
	position := eye canvas camera fromPixelToSpace: position.
	eyepos := eye parent position + eye position.
	angle := (position - eyepos) angle.
	iris := eye children second.
	dist := position distanceTo: eyepos.
	dist := dist min: 7.
	iris translateTo: (angle cos @ angle sin) * dist
]

{ #category : #updating }
RSAmeba >> updateEyes [
	self updateEye: self shape children second.
	self updateEye: self shape children third
]
