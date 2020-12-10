"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #RSLabelTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSLabelTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #tests }
RSLabelTest >> testBuilding [

	| l |
	l := RSLabel text: 'Hello'.
	self assert: l class equals: RSLabel.
	self assert: l text equals: 'Hello'
	
]

{ #category : #tests }
RSLabelTest >> testBuilding2 [

	| l |
	l := RSLabel text: 'Hello' model: 42.
	self assert: l class equals: RSLabel.
	self assert: l text equals: 'Hello'.
	self assert: l model equals: 42.
	
]

{ #category : #tests }
RSLabelTest >> testCairoCachedMetricProvider [
	| label provider |
	label := RSLabel new.
	label text: ''.
	provider := RSCairoCachedMetricsProvider new.
	label metricsProvider: provider.
	
	self assert: label extent class equals: Point.
	self assert: (provider extentsOf: label) class equals: RSTextExtents.
]

{ #category : #tests }
RSLabelTest >> testCairoFitMetricsProvider [
	| label h |
	label := RSLabel new.
	label text: '.'.
	h := label height.
	label metricsProvider: (RSCairoFitMetricsProvider new).
	self assert: h > label height.
]

{ #category : #tests }
RSLabelTest >> testDrawBorderLabel [
	|  |
	canvas addShape: (RSLabel new
		withBorder;
		color: (Color purple alpha: 0.5);
		fontName: 'Source Sans Pro';
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSLabelTest >> testDrawLabel [
	
	canvas addShape: (RSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSLabelTest >> testHasChildren [
	| b |
	b := RSLabel new.
	self deny: b hasChildren.
	
]

{ #category : #tests }
RSLabelTest >> testModelWithoutText [

	| l |
	l := RSLabel new.
	self assert: l text isNil.
	self assert: l model isNil.
	
	l model: 42.
	self assert: l model equals: 42.
	self assert: l text equals: '42'
]

{ #category : #tests }
RSLabelTest >> testSameSize [
	| l1 l2 |
	l1 := RSLabel model: 123.
	l2 := RSLabel new text: 123.
	
	self assert: l1 extent equals: l2 extent
]

{ #category : #tests }
RSLabelTest >> testUnderlineStruckout [
	| label |
	label := RSLabel new.
	self assert: label isNormal.
	label underline.
	label bold.
	self assert: label isBold.
	self assert: label isUnderlined.
]
