"
Basic example of how to use SpRoassalPresenter, use it as a reference of how interact with some spec components
"
Class {
	#name : 'RSBasicSpecExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'roassalSpec'
	],
	#category : 'Roassal-Spec-Examples-Basic',
	#package : 'Roassal-Spec-Examples',
	#tag : 'Basic'
}

{ #category : 'layout' }
RSBasicSpecExample class >> defaultLayout [
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #roassalSpec;
		yourself
]

{ #category : 'initialization' }
RSBasicSpecExample >> initializePresenters [
	roassalSpec := self newRoassal.
	self initializeRoassal: roassalSpec canvas
]

{ #category : 'initialization' }
RSBasicSpecExample >> initializeRoassal: canvas [
	| slice magic |
	slice := RSPieSlice new.
	slice
		innerRadius: 100;
		externalRadius: 150;
		alphaAngle: 15;
		betaAngle: 180.
	slice when: RSMouseEnter do: [ slice color: Color random; signalUpdate  ].
	canvas add: slice.

	canvas add: (RSLine new
		startPoint: 0@ -200;
		endPoint: 0 @ 200;
		dashed;
		markerStartEnd: (RSShapeFactory arrow
			size: 10);
		yourself).
	canvas add: (RSLine new
		startPoint: -200@ 0;
		endPoint: 200 @ 0;
		dashed;
		markerStartEnd: (RSShapeFactory arrow
			size: 10);
		yourself).
	canvas add: (RSLabel new
		text: '0@0';
		position: 20@10;
		yourself).
	magic := 160*0.551784.
	canvas add: (RSBezier new
		width: 3;
		dashed;
		markerEnd: (RSShapeFactory arrow
			size: 20;
			color: Color black);
		controlPoints:
			{160@0.
			160@ magic negated.
			magic@ -160.
			0@ -160  };
		yourself
		).
	canvas add: (RSLabel new
		text: 'Angle direction';
		color: 'blue';
		position: 180@ -130;
		yourself)
]

{ #category : 'initialization' }
RSBasicSpecExample >> initializeWindow: w [
	w
		title: 'Basic plot';
		initialExtent: 800@500;
		centered
]

{ #category : 'running' }
RSBasicSpecExample >> run [
	<script: 'self new asWindow open'>
]
