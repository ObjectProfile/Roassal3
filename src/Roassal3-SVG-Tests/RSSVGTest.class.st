Class {
	#name : #RSSVGTest,
	#superclass : #RSCanvasTest,
	#category : #'Roassal3-SVG-Tests'
}

{ #category : #tests }
RSSVGTest >> testBimetricLine [
	| s1 s2 l |
	canvas := RSCanvas new.
	s1 := RSBox new
		color: Color blue;
		draggable;
		size: 100;
		yourself.
	s2 := RSBox new
		translateTo: 400@0;
		draggable;
		size: 100;
		yourself.
	l := RSBimetricLine new
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: s1;
		to: s2;
		yourself.
	canvas addAll: { s1. s2. l}.
	^ canvas
]

{ #category : #tests }
RSSVGTest >> testDrawSVG [
	canvas addShape: (RSSVGPath new).
	canvas addShape: (RSSVGPath new
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	canvas createMorph drawOnMockCanvas
]

{ #category : #tests }
RSSVGTest >> testDrawSVGLine [
	canvas addShape: (RSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :aLine | 'M 100 100 L 200 200' ];
		width: 2).
	canvas addShape: (RSSVGPathLine new
		strokeColor: Color red;
		svgPath: [:aLine | String streamContents: [:stream |
			| a b |
			a := aLine startPoint.
			b := aLine endPoint.
			stream
				nextPutAll: 'M ';
				nextPutAll: a x asString;
				space;
				nextPutAll: a y asString;
				space;
				nextPutAll: 'L ';
				nextPutAll: b x asString;
				space;
				nextPutAll: b y asString.
		] ];
		startPoint: 100@100;
		endPoint: 200@200;
		width: 2).
	canvas addShape: (RSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :aLine | [ :aCanvas|
			aCanvas
				absolute;
				moveTo: aLine startPoint;
				lineTo: aLine endPoint. ] ];
		width: 2).
	canvas createMorph drawOnMockCanvas
]
