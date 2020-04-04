"
Test for all the lines of trachel
"
Class {
	#name : #RSLinesTest,
	#superclass : #RSCanvasTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #'tests - colors' }
RSLinesTest >> testColorLineAndMarker [
	| line |
	line := RSShapeFactory arrowedLine.
	line color: Color blue.
	self 
		assert: line color equals: Color blue;
		assert: line markerEnd shape borderColor equals: Color blue.
]

{ #category : #running }
RSLinesTest >> testDrawBezierLine [
	c addShape: (RSBezier new
		strokeColor: Color red;
		width: 2). 
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testDrawLine [
	c addShape: (RSLine new
		strokeColor: Color red;
		width: 2). 
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testDrawMarkers [
	| line m |
	m := RSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	line := RSLine new
		startPoint: 50@50;
		endPoint: 250@50.
	line markerStart: m.
	c addShape: line.
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testDrawSVGLine [
	c addShape: (RSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :aLine | 'M 100 100 L 200 200' ];
		width: 2). 
	c addShape: (RSSVGPathLine new
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
	c addShape: (RSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :aLine | [ :canvas| 
			canvas
				absolute;
				moveTo: aLine startPoint;
				lineTo: aLine endPoint. ] ];
		width: 2). 
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testPolyline [
	| line |
	line := RSPolyline new.
	line controlPoints: { 0@0. 0@100 }.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 5@50).
	
	self deny: (line includesPoint: 500@500).
	self deny: (line includesPoint: 6@50).
]

{ #category : #running }
RSLinesTest >> testPolylineBasic [
	| line |
	line := RSPolyline new.
	
	self deny: (line includesPoint: 500@500).
	self deny: (line includesPoint: 6@50).
	self assert: line controlPoints equals: #()
]
