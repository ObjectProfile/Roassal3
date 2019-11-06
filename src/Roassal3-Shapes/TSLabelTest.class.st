"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #TSLabelTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
TSLabelTest >> testDrawBorderLabel [
	|  |
	c addShape: (TSLabel new
		withBorder;
		color: (Color purple alpha: 0.5);
		fontName: 'Source Sans Pro';
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
TSLabelTest >> testDrawLabel [
	
	c addShape: (TSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
TSLabelTest >> testUnderlineStruckout [
	| label |
	label := TSLabel new.
	self assert: label isNormal.
	label underline.
	label bold.
	self assert: label isBold.
	self assert: label isUnderlined.
]
