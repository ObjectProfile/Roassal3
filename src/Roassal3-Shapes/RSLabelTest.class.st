"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #RSLabelTest,
	#superclass : #RSCanvasTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSLabelTest >> testDrawBorderLabel [
	|  |
	c addShape: (RSLabel new
		withBorder;
		color: (Color purple alpha: 0.5);
		fontName: 'Source Sans Pro';
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSLabelTest >> testDrawLabel [
	
	c addShape: (RSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c createMorph drawOnMockCanvas.
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
