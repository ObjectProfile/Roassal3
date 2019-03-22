"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #TSLabelTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSLabelTest >> testDrawBorderLabel [
	|  |
	c addShape: (TSLabel new
		border: (TSBorder new);
		color: (Color purple alpha: 0.5);
		fontName: 'Source Sans Pro';
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c morph drawOnMockCanvas.
]

{ #category : #tests }
TSLabelTest >> testDrawLabel [
	
	c addShape: (TSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c morph drawOnMockCanvas.
]
