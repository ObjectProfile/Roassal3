"
Test for all the lines of trachel
"
Class {
	#name : #TSLinesTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #running }
TSLinesTest >> testDrawBezierLine [
	c addShape: (TSBezier new
		strokeColor: Color red;
		width: 2). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSLinesTest >> testDrawLine [
	c addShape: (TSLine new
		strokeColor: Color red;
		width: 2). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSLinesTest >> testDrawSVGLine [
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :a :b | 'M 100 100 L 200 200' ];
		width: 2). 
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [:a :b | String streamContents: [:stream |
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
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :a :b | [ :canvas| 
			canvas
				absolute;
				moveTo: a;
				lineTo: b. ] ];
		width: 2). 
	c morph drawOnMockCanvas.
]
