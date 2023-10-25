"
Test for all the lines of trachel
"
Class {
	#name : 'RSLinesTest',
	#superclass : 'RSTest',
	#instVars : [
		'canvas'
	],
	#category : 'Roassal-Shapes-Tests',
	#package : 'Roassal-Shapes-Tests'
}

{ #category : 'running' }
RSLinesTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : 'tests' }
RSLinesTest >> testArrowedLine [
	| line head other |
	line := RSArrowedLine new.
	line startPoint: 0@0; endPoint: 100@100.
	head := line markerEnd.
	self assert: head isNotNil.

	head := head shape.
	self assert: head class equals: RSPolygon.
	line color: Color blue.
	self assert: line color equals: Color blue.
	self assert: head border color equals: Color blue.

	line border: (RSBorder new width: 2; color: Color red).
	self assert: line border width equals: 2.
	self assert: line color equals: Color red.
	self assert: head border width equals: 2.
	self assert: line color equals: Color red.

	other := line copy.
	self deny: other equals: line.
	self deny: other markerEnd hash equals: line markerEnd hash
]

{ #category : 'tests - colors' }
RSLinesTest >> testColorLineAndMarker [
	| line |
	line := RSShapeFactory arrowedLine.
	line color: Color blue.
	self
		assert: line color equals: Color blue;
		assert: line markerEnd shape borderColor equals: Color blue
]

{ #category : 'tests' }
RSLinesTest >> testDrawBezierLine [
	canvas addShape: (RSBezier new
		strokeColor: Color red;
		width: 2).
	canvas createMorph drawOnMockCanvas
]

{ #category : 'tests' }
RSLinesTest >> testDrawLine [
	canvas addShape: (RSLine new
		strokeColor: Color red;
		width: 2).
	canvas createMorph drawOnMockCanvas
]

{ #category : 'tests' }
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
	canvas addShape: line.
	canvas createMorph drawOnMockCanvas
]

{ #category : 'tests - geometry' }
RSLinesTest >> testEmcompassingRectangleForDiagonalLine [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@100;
		width: 1;
		yourself.
	self assert: line encompassingRectangle extent > (100@100)
]

{ #category : 'tests - geometry' }
RSLinesTest >> testEmcompassingRectangleForLineWithMarker [
	| line marker |
	marker := RSShapeFactory triangle.
	marker size: 10.
	marker := marker asMarker.
	marker offset: -5.
	line := RSLine new
		startPoint: 0 @ 0;
		endPoint: 0 @ 100;
		markerEnd: marker;
		width: 1;
		yourself.
	self
		assert: line encompassingRectangle
		closeTo: (-5 @ 0 corner: 5 @ 110)
]

{ #category : 'tests - geometry' }
RSLinesTest >> testEmcompassingRectangleForVerticalLineWidth10 [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 0@100;
		width: 10;
		yourself.
	self assert: line encompassingRectangle equals: (-5@0 corner: 5@100)
]

{ #category : 'tests' }
RSLinesTest >> testEmptyFormat [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	line format: ''.
	self assert: line color equals: Color gray.
	self assert: line markerStart isNil
]

{ #category : 'tests' }
RSLinesTest >> testFmt [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	self assert: line border style isNil.
	self assert: line markerEnd isNil.
	line format: '.^'.
	self deny: line border style dashArray isNil.
	self deny: line markerEnd isNil.
	self deny: line markerStart isNil.
	self assert: line markerEnd shape color equals: line color
]

{ #category : 'tests' }
RSLinesTest >> testFormat [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	line format: 'r-o'.
	self assert: line color equals: Color red.
	self assert: line markerEnd shape class equals: RSEllipse.
	line format: 'gs'.
	self assert: line color equals: Color green.
	line format: 'bs'.
	self assert: line color equals: Color blue.
	self assert: line markerEnd shape class equals: RSPolygon
]

{ #category : 'tests' }
RSLinesTest >> testFormatMarker [
	| line markerShape|
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	line format: 'o'.
	markerShape := line markerEnd shape.
	self assert: markerShape class equals: RSEllipse.
	self assert: markerShape extent equals: line markerSizeScale asPoint.
	line format: 's'.
	self deny: line markerEnd shape class equals: markerShape
]

{ #category : 'tests' }
RSLinesTest >> testInvert [
	| line positionBefore |
	line := RSLine new.
	line controlPoints: {0.5@2. 1.5@2}.
	positionBefore := line position.
	line invert.
	self assert: line controlPoints equals: {2@0.5. 2@1.5}.
	self assert: line position equals: positionBefore y @ positionBefore x
]

{ #category : 'tests' }
RSLinesTest >> testLineIncludesPoint [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 0@100;
		width: 8;
		yourself.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 4@50).
	self deny: (line includesPoint: 5@50).
	self deny: (line includesPoint: 500@500)
]

{ #category : 'tests' }
RSLinesTest >> testMarkerOffset [
	| line marker |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	marker := RSBox new size: 20; withBorder; noPaint; asMarker.
	marker offsetRatio: 0.5.
	line markerEnd: marker.

	self assert: (line includesPoint: 50@ 9).
	marker offset: 20.
	self deny: (line includesPoint: 50@ 9).
	self assert: (line includesPoint: 30@ 9)
]

{ #category : 'tests' }
RSLinesTest >> testMarkersIncludesPoint [
	| line marker |
	line := RSLine new
		startPoint: 0@ 0;
		endPoint: 200@0;
		yourself.
	marker := RSBox new
		size: 20;
		asMarker.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 100@0).
	self assert: (line includesPoint: 200@0).
	self deny: (line includesPoint: 210@0).
	self deny: (line includesPoint: 210@10).
	self deny: (line includesPoint: 210@ -10).
	line markerEnd: marker.
	self assert: (line includesPoint: 210@0).
	self assert: (line includesPoint: 200@9).
	self assert: (line includesPoint: 210@ -10).
	self deny: (line includesPoint: 210@ -11)
]

{ #category : 'tests' }
RSLinesTest >> testPolylineIncludesPoint [
	| line |
	line := RSPolyline new.
	line width: 10.
	line controlPoints: { 0@0. 0@100 }.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 5@50).

	self deny: (line includesPoint: 500@500).
	self deny: (line includesPoint: 6@50)
]

{ #category : 'tests' }
RSLinesTest >> testStroke [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 100@0;
		yourself.
	line format: '--'.
	self assert: line border dashArray equals: #(4 2).
	line format: '-.'.
	self assert: line border dashArray equals: #(4 1 1 1).
	line format: '.'.
	self assert: line border dashArray equals: #(1)
]
