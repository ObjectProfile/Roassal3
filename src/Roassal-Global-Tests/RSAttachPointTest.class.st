Class {
	#name : 'RSAttachPointTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Shapes',
	#package : 'Roassal-Global-Tests',
	#tag : 'Shapes'
}

{ #category : 'tests' }
RSAttachPointTest >> testBorderAttachPoint [
	| b1 b2 l c |
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSBorderAttachPoint new.
	l update.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	self assert: (l attachPoint startingPointOf: l) equals: 30 @ 35.
	self assert: (l attachPoint endingPointOf: l) equals: 50 @ 45
]

{ #category : 'tests' }
RSAttachPointTest >> testCenteredAttachPoint [
	| b1 b2 l c |
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSCenteredAttachPoint new.
	l update.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	self assert: (l attachPoint startingPointOf: l) equals: 20 @ 30.
	self assert: (l attachPoint endingPointOf: l) equals: 60 @ 50
]

{ #category : 'tests' }
RSAttachPointTest >> testHorizontalAttachPoint [
	| b1 b2 l c |
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSHorizontalAttachPoint new.
	l update.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	self assert: (l attachPoint startingPointOf: l) equals: 30 @ 30.
	self assert: (l attachPoint endingPointOf: l) equals: 50 @ 50
]

{ #category : 'tests' }
RSAttachPointTest >> testInverted [
	| ap e1 e2 line |
	ap := RSCenteredAttachPoint new.
	ap straight.
	self deny: ap isInverted.
	e1 := RSEllipse new.
	e2  := RSEllipse new.
	e1 translateTo: 20 asPoint.
	line := RSLine new.
	line attachPoint: ap.
	line from: e1.
	line to: e2.
	line update.
	self assert: e1 position equals: line startPoint.
	ap inverted.
	line update.
	self assert: e1 position equals: line endPoint
]

{ #category : 'tests' }
RSAttachPointTest >> testVerticalAttachPoint [
	| b1 b2 l c |
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSVerticalAttachPoint new.
	l update.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	self assert: (l attachPoint startingPointOf: l) equals: 20 @ 40.
	self assert: (l attachPoint endingPointOf: l) equals: 60 @ 40
]
