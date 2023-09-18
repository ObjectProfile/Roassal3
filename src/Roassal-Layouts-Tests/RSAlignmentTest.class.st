Class {
	#name : #RSAlignmentTest,
	#superclass : #TestCase,
	#instVars : [
		'align'
	],
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #running }
RSAlignmentTest >> setUp [
	super setUp.
	align := RSAlignment new
]

{ #category : #tests }
RSAlignmentTest >> testCenter [
	| es |
	es := (1 to: 5) collect: [ :v | RSBox new size: 10 ] as: RSGroup.
	RSHorizontalLineLayout on: es.
	align shapes: es.
	self assert: align middle equals: align.
	self assert: es encompassingRectangle equals: ((0.0@0.0) corner: (70.0@10.0))
]

{ #category : #tests }
RSAlignmentTest >> testFromBottom [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSHorizontalLineLayout on: es.
	es second translateBy: 0 @ 150.
	self assert: (es collect: [ :e | e encompassingRectangle bottom ]) asArray equals: #(10.0 170.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0).
	self assert: align bottomMostShape equals: es second.
	align bottom.
	self assert: (es collect: [ :e | e encompassingRectangle bottom ]) asArray equals: #(170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromLeft [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSVerticalLineLayout on: es.
	es second translateBy: -150 @ 0.
	self assert: (es collect: [ :e | e encompassingRectangle left ]) asArray equals: #(0.0 -150.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0).
	self assert: align leftMostShape equals: es second.
	align left.
	self assert: (es collect: [ :e | e encompassingRectangle left ]) asArray equals: #(-150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromLeftWithAFixShape [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSVerticalLineLayout on: es.
	es second translateBy: -150 @ 0.
	align fixedShape: es first.
	align left.
	self assert: (es collect: [ :e | e encompassingRectangle left ]) asArray equals: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromLeftWithFixedShape [
	| es c |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSVerticalLineLayout on: es.
	es second translateBy: -150 @ 0.

	c := RSCanvas new.
	c addAll: es.
	es do: [ :s | s setAsFixed ].

	self assert: (es collect: [ :e | e encompassingRectangle left ]) asArray equals: #(0.0 -150.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0).
	self assert: align leftMostShape equals: es second.
	align left.
	self assert: (es collect: [ :e | e encompassingRectangle left ]) asArray equals: #(-150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0 -150.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromRight [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSVerticalLineLayout on: es.
	es second translateBy: 150 @ 0.
	self assert: (es collect: [ :e | e encompassingRectangle right ]) asArray equals: #(10.0 170.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0).
	self assert: align rightMostShape equals: es second.
	align right.
	self assert: (es collect: [ :e | e encompassingRectangle right ]) asArray equals: #(170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0 170.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromTop [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSHorizontalLineLayout on: es.
	es second translateBy: 0 @ -50.
	self assert: (es collect: [ :e | e encompassingRectangle top ]) asArray equals: #(0.0 -50.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0).
	self assert: align topMostShape equals: es second.
	align top.
	self assert: (es collect: [ :e | e encompassingRectangle top ]) asArray equals: #(-50.0 -50.0 -50.0 -50.0 -50.0 -50.0 -50.0 -50.0 -50.0 -50.0)
]

{ #category : #tests }
RSAlignmentTest >> testFromTopWithAFixShape [
	| es |
	es := (10 to: 100 by: 10) collect: [ :n | RSBox new size: n; yourself ].
	align shapes: es.
	RSHorizontalLineLayout on: es.
	es second translateBy: 0 @ -50.
	align fixedShape: es third.

	self assert: (es collect: [ :e | e encompassingRectangle top ]) asArray equals: #(0.0 -50.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0).
	self assert: align topMostShape equals: es third.
	align top.
	self assert: (es collect: [ :e | e encompassingRectangle top ]) asArray equals: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
]

{ #category : #tests }
RSAlignmentTest >> testHasElement [
	self deny: align hasShape.
	align shapes: (Array with: RSBox new).
	self assert: align hasShape.
	align shapes: #().
	self deny: align hasShape
]

{ #category : #tests }
RSAlignmentTest >> testNoErrorOnDefault [

	RSAlignment new left; right; top; bottom
]
