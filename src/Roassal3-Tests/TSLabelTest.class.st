"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #TSLabelTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSLabelTest >> testDrawLabel [
	| c |
	c := TSCanvas new.
	c addShape: (TSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	c morph drawOnMockCanvas.
]
