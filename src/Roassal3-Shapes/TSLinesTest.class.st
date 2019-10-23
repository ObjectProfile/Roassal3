"
Test for all the lines of trachel
"
Class {
	#name : #TSLinesTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
TSLinesTest >> testDrawBezierLine [
	c addShape: (TSBezier new
		strokeColor: Color red;
		width: 2). 
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
TSLinesTest >> testDrawLine [
	c addShape: (TSLine new
		strokeColor: Color red;
		width: 2). 
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
TSLinesTest >> testDrawMarkers [
	| line m |
	m := TSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	line := TSLine new
		startPoint: 50@50;
		endPoint: 250@50.
	line markerStart: m.
	c addShape: line.
	c createMorph drawOnMockCanvas.
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
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
TSLinesTest >> testPolyline [
	| line |
	line := TSPolyline new.
	line controlPoints: { 0@0. 0@100 }.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 5@50).
	
	self deny: (line includesPoint: 500@500).
	self deny: (line includesPoint: 6@50).
]
