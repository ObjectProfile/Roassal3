Class {
	#name : #RSSVGTest,
	#superclass : #RSCanvasTest,
	#category : #'Roassal3-SVG-Tests'
}

{ #category : #'as yet unclassified' }
RSSVGTest >> testDrawSVG [
	canvas addShape: (RSSVGPath new).
	canvas addShape: (RSSVGPath new
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	canvas createMorph drawOnMockCanvas.
]

{ #category : #'as yet unclassified' }
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
		svgPath: [ :aLine | [ :canvas| 
			canvas
				absolute;
				moveTo: aLine startPoint;
				lineTo: aLine endPoint. ] ];
		width: 2). 
	canvas createMorph drawOnMockCanvas.
]
